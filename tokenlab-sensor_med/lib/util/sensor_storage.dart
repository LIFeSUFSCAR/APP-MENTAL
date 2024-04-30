import 'dart:io';

import 'package:hive/hive.dart';
// ignore: implementation_imports
import 'package:hive/src/hive_impl.dart';
import 'package:retry/retry.dart';
import 'package:sensor_med/model/debug_level.dart';
import 'package:sensor_med/model/fields_parameters.dart';
import 'package:sensor_med/model/send_status.dart';
import 'package:sensor_med/model/sensor_data.dart';
import 'package:sensor_med/model/sensor_parameters.dart';
import 'package:sensor_med/model/sensor_type.dart';
import 'package:synchronized/synchronized.dart';

/// Class to store sensor data and parameters.
/// It uses Hive to store data in the device, with a singleton pattern
/// to avoid multiple instances of the class.
/// It also uses a lock to avoid concurrent access to the data, and a retry
/// mechanism to avoid errors when accessing the data.
class SensorStorage {
  /// Class to store sensor data and parameters.
  /// It uses Hive to store data in the device, with a singleton pattern
  /// to avoid multiple instances of the class.
  /// It also uses a lock to avoid concurrent access to the data, and a retry
  /// mechanism to avoid errors when accessing the data.
  SensorStorage({
    required this.directory,
    required this.parametersBox,
    required this.box,
  });

  /// Directory to store the saved data.
  final Directory directory;

  /// Box to store the sensor parameters.
  final Box<SensorParameters> parametersBox;

  /// Box to store the sensor data.
  final Box<SensorData> box;

  /// Lock to avoid concurrent access to the data.
  static final lock = Lock();

  /// Singleton instance of the class.
  static SensorStorage? _instance;

  /// Hive interface to store the data.
  static late HiveInterface hive;

  /// Create a new instance of the class, or return the existing one.
  /// It uses a lock to avoid concurrent access to the data and initialize
  /// the Hive interface to store the data.
  /// It also registers the adapters for the different classes used to store
  /// the data.
  /// Returns the singleton instance of the class.
  static Future<SensorStorage> create({
    required Directory directory,
  }) async {
    return lock.synchronized(
      () async {
        if (_instance != null) return _instance!;

        hive = HiveImpl();
        Box<SensorParameters> parametersBox;
        Box<SensorData> box;

        hive
          ..init(directory.path)
          ..registerAdapter(FieldsParametersAdapter())
          ..registerAdapter(SensorDataAdapter())
          ..registerAdapter(DebugLevelAdapter())
          ..registerAdapter(SensorParametersAdapter())
          ..registerAdapter(SendStatusAdapter())
          ..registerAdapter(SensorTypeAdapter());
        parametersBox = await hive.openBox('parameters');
        box = await hive.openBox('sensor_data');

        return _instance = SensorStorage(
          directory: directory,
          box: box,
          parametersBox: parametersBox,
        );
      },
    );
  }

  /// Close the boxes used to store the data.
  Future<void> close() async {
    if (box.isOpen) {
      await box.close();
    }

    if (parametersBox.isOpen) {
      await parametersBox.close();
    }
  }

  /// Clear all the data stored in the boxes.
  Future<void> clearAll() async {
    await lock.synchronized(
      () async {
        await parametersBox.clear();
        await box.clear();
      },
    );
  }

  /// Clear the parameters stored in the box.
  Future<void> clearParameters() async {
    await lock.synchronized(
      () async {
        await parametersBox.clear();
      },
    );
  }

  /// Clear the data stored in the box.
  Future<void> clearData() async {
    await lock.synchronized(
      () async {
        await box.clear();
      },
    );
  }

  /// Save the parameters in the box.
  Future<void> saveParameters(SensorParameters parameters) async {
    await parametersBox.put('parameters', parameters);
  }

  /// Get the parameters stored in the box.
  Future<SensorParameters?> getParameters() async {
    return parametersBox.get('parameters');
  }

  /// Save the sensor data in the box.
  Future<void> saveData(SensorData data) async {
    await lock.synchronized(
      () async {
        await box.add(data);
      },
    );
  }

  /// Save a list of sensor data in the box.
  Future<void> saveDataList(List<SensorData> dataList) async {
    await lock.synchronized(
      () async {
        await box.addAll(dataList);
      },
    );
  }

  /// Get the sensor data stored in the box.
  Future<List<SensorData>> getData() async {
    return box.values.toList();
  }

  /// Delete the sensor data stored in the box with the status 'sent'.
  Future<void> deleteSentData({
    required Lock lock,
  }) async {
    final dataList = await getData();
    final sendedDataList = dataList
        .where(
          (data) => data.status == SendStatus.sent,
        )
        .toList();

    if (sendedDataList.isEmpty) return;
    await lock.synchronized(
      () async {
        for (final data in sendedDataList) {
          await retryOperation(
            () async {
              await box.clear();
            },
          );
        }
      },
    );
  }

  /// Update the sensor data stored in the box with the status 'sent'.
  Future<SensorData?> updateData({
    required SensorData data,
    required SendStatus status,
    required Lock lock,
  }) async {
    final index = box.values.toList().indexOf(data);
    final item = box.getAt(index);
    if (item != null) {
      final newItem = SensorData(
        type: item.type,
        status: status,
        timestamp: item.timestamp,
        data: item.data,
      );
      await lock.synchronized(
        () async {
          await box.putAt(index, newItem);
        },
      );
      return newItem;
    }
    return null;
  }

  /// Update the sensor data stored changing the status to the chosen one.
  Future<List<SensorData?>> updateDataList({
    required List<SensorData> dataList,
    required SendStatus status,
    required Lock lock,
  }) async {
    final updatedDataList = <SensorData?>[];

    await lock.synchronized(
      () async {
        for (final data in dataList) {
          await retryOperation(
            () async {
              final index = box.values.toList().indexOf(data);
              final item = box.getAt(index);
              if (item != null) {
                final newItem = SensorData(
                  type: item.type,
                  status: status,
                  timestamp: item.timestamp,
                  data: item.data,
                );
                await box.putAt(index, newItem);
                updatedDataList.add(newItem);
              }
            },
          );
        }
      },
    );

    return updatedDataList;
  }

  /// Retry an operation in case of error.
  Future<T> retryOperation<T>(
    Future<T> Function() callback, {
    int maxAttempts = 3,
    Duration maxDelay = const Duration(
      milliseconds: 100,
    ),
  }) async {
    final parameters = await getParameters() ??
        const SensorParameters(
          url: '',
        );
    return retry<T>(
      callback,
      maxAttempts: maxAttempts,
      maxDelay: maxDelay,
      onRetry: (e) {
        if (parameters.showDebug == DebugLevel.verbose ||
            parameters.showDebug == DebugLevel.error) {
          print('Retrying operation: $e');
        }
        throw e;
      },
    );
  }
}
