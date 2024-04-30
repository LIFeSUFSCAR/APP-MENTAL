import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:rxdart/rxdart.dart';
import 'package:screen_state/screen_state.dart';
import 'package:sensor_med/model/debug_level.dart';
import 'package:sensor_med/model/send_status.dart';
import 'package:sensor_med/model/sensor_data.dart';
import 'package:sensor_med/model/sensor_parameters.dart';
import 'package:sensor_med/model/sensor_type.dart';
import 'package:sensor_med/util/sensor_storage.dart';
import 'package:sensor_med/util/timer_utils.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:synchronized/synchronized.dart';

/// Class to manage the sensors and the data capture and storage.
/// This class is responsible for starting the sensors, capturing the data,
/// storing the data, sending the data and managing the health data.
/// The sensors are: gyroscope, accelerometer, location, screen state and
/// health.
/// The data is stored in the local storage and sent to the server.
class SensorsManager {
  /// List of health data types to be captured.
  /// The list is different for Android and iOS.
  /// The default list is: SLEEP_ASLEEP, SLEEP_AWAKE, SLEEP_DEEP, SLEEP_REM.
  /// For Android, the list includes: SLEEP_LIGHT.
  /// For iOS, the list includes: SLEEP_IN_BED.
  List<HealthDataType> get healthTypes {
    final types = <HealthDataType>[]..addAll(
        [
          HealthDataType.SLEEP_ASLEEP,
          HealthDataType.SLEEP_AWAKE,
          HealthDataType.SLEEP_DEEP,
          HealthDataType.SLEEP_REM,
        ],
      );

    if (Platform.isAndroid) {
      types.addAll([
        HealthDataType.SLEEP_LIGHT,
      ]);
    }

    if (Platform.isIOS) {
      types.addAll([
        HealthDataType.SLEEP_IN_BED,
      ]);
    }

    return types;
  }

  var email = "";

  final _dateFormatter = DateFormat('dd-MM-yyyy');

  final _sensors = Sensors();

  /// Method to start the gyroscope sensor.
  /// Requires the [parameters] and the [storage].
  /// - [parameters] is the configuration for the sensor.
  /// - [storage] is the local storage to store the data.
  /// Returns a [Future] with a [StreamSubscription] of [GyroscopeEvent].
  Future<StreamSubscription<GyroscopeEvent>?> startGyroscope({
    required SensorParameters parameters,
    required SensorStorage storage,
  }) async {
    // TODO(any): Ajustar a captura dos sensores
    if (parameters.showDebug == DebugLevel.verbose) {
      debugPrint('Starting the gyroscope service!');
    }
    return _sensors
        .gyroscopeEventStream()
        .throttleTime(
          Duration(
            milliseconds: parameters.captureDataThrottle,
          ),
          leading: false,
          trailing: true,
        )
        .listen(
          (event) async {
            if (parameters.showDebug == DebugLevel.verbose) {
              debugPrint('Gyroscope event: ${event.toString()}');
            }
            await storage.saveData(
              SensorData(
                type: SensorType.gyroscope,
                status: SendStatus.waiting,
                timestamp: DateTime.now(),
                data: {
                  'x': event.x,
                  'y': event.y,
                  'z': event.z,
                },
              ),
            );
          },
          cancelOnError: false,
          onError: (error) {
            if (parameters.showDebug == DebugLevel.error ||
                parameters.showDebug == DebugLevel.verbose) {
              debugPrint('Gyroscope error: $error');
            }
            if (error is Exception) {
              throw error;
            }
          },
        );
  }

  /// Method to start the accelerometer sensor.
  /// Requires the [parameters] and the [storage].
  /// - [parameters] is the configuration for the sensor.
  /// - [storage] is the local storage to store the data.
  /// Returns a [Future] with a [StreamSubscription]
  /// of [UserAccelerometerEvent].
  Future<StreamSubscription<UserAccelerometerEvent>> startAccelerometer({
    required SensorParameters parameters,
    required SensorStorage storage,
  }) async {
    if (parameters.showDebug == DebugLevel.verbose) {
      debugPrint('Starting the user accelerometer service!');
    }

    // TODO(any): Ajustar a captura dos sensores
    return _sensors
        .userAccelerometerEventStream()
        .throttleTime(
          Duration(
            milliseconds: parameters.captureDataThrottle,
          ),
          leading: false,
          trailing: true,
        )
        .listen(
          (event) {
            if (parameters.showDebug == DebugLevel.verbose) {
              debugPrint('User accelerometer event: ${event.toString()}');
            }
            storage.saveData(
              SensorData(
                type: SensorType.accelerometer,
                status: SendStatus.waiting,
                timestamp: DateTime.now(),
                data: {
                  'x': event.x,
                  'y': event.y,
                  'z': event.z,
                },
              ),
            );
          },
          cancelOnError: false,
          onError: (error) {
            if (parameters.showDebug == DebugLevel.error ||
                parameters.showDebug == DebugLevel.verbose) {
              debugPrint('User accelerometer error: $error');
            }
            if (error is Exception) {
              throw error;
            }
          },
        );
  }

  /// Method to start the location sensor.
  /// Requires the [parameters] and the [storage].
  /// - [parameters] is the configuration for the sensor.
  /// - [storage] is the local storage to store the data.
  /// Returns a [Future] with a [StreamSubscription] of [Position].
  Future<StreamSubscription<Position>?> startLocation({
    required SensorParameters parameters,
    required SensorStorage storage,
  }) async {
    if (parameters.showDebug == DebugLevel.verbose) {
      debugPrint('Starting the location service!');
    }

    final status = await permission.Permission.location.status;
    final serviceStatus = await permission.Permission.location.serviceStatus;
    if (status.isGranted && serviceStatus == permission.ServiceStatus.enabled) {
      LocationSettings? locationSettings;

      if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          forceLocationManager: true,
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationTitle: 'Sensor Med',
            notificationText: 'Capturando dados dos sensores...',
            enableWakeLock: true,
            enableWifiLock: true,
          ),
        );
      }

      if (Platform.isIOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.other,
          allowBackgroundLocationUpdates: true,
        );
      }

      return Geolocator.getPositionStream(
        locationSettings: locationSettings,
      )
          .throttleTime(
        Duration(
          milliseconds: parameters.captureDataThrottle,
        ),
        leading: false,
        trailing: true,
      )
          .listen(
        (position) {
          storage.saveData(
            SensorData(
              type: SensorType.gps,
              status: SendStatus.waiting,
              timestamp: DateTime.now(),
              data: {
                'latitude': position.latitude,
                'longitude': position.longitude,
                'altitude': position.altitude,
                'accuracy': position.accuracy,
                'altitudeAccuracy': position.altitudeAccuracy,
                'speed': position.speed,
                'speedAccuracy': position.speedAccuracy,
                'heading': position.heading,
                'headingAccuracy': position.headingAccuracy,
                'floor': position.floor,
                'time': position.timestamp?.toIso8601String(),
              },
            ),
          );

          if (parameters.showDebug == DebugLevel.verbose) {
            debugPrint('Location: Latitude: ${position.latitude}, '
                'Longitude: ${position.longitude} '
                'Accuracy: ${position.accuracy} '
                'Altitude: ${position.altitude} '
                'Altitude Accuracy: ${position.altitudeAccuracy} '
                'Speed: ${position.speed} '
                'Speed Accuracy: ${position.speedAccuracy} '
                'Heading: ${position.heading} '
                'Heading Accuracy: ${position.headingAccuracy} '
                'Floor: ${position.floor} '
                'Time: ${position.timestamp.toString()}');
          }
        },
        onError: (error) {
          if (parameters.showDebug == DebugLevel.error ||
              parameters.showDebug == DebugLevel.verbose) {
            debugPrint('Location error: $error');
          }

          if (error is Exception) {
            throw error;
          }
        },
      );
    }
    return null;
  }

  /// Method to start the screen state sensor.
  /// Requires the [parameters] and the [storage].
  /// - [parameters] is the configuration for the sensor.
  /// - [storage] is the local storage to store the data.
  /// Returns a [Future] with a [StreamSubscription] of [ScreenStateEvent].
  Future<StreamSubscription<ScreenStateEvent>> startScreenState({
    required SensorParameters parameters,
    required SensorStorage storage,
  }) async {
    final screen = Screen();
    if (parameters.showDebug == DebugLevel.verbose) {
      debugPrint('Starting the screen state service!');
    }
    return screen.screenStateStream.listen(
      (state) async {
        late String stringState;

        switch (state) {
          case ScreenStateEvent.SCREEN_ON:
            stringState = 'SCREEN_ON';
            break;
          case ScreenStateEvent.SCREEN_OFF:
            stringState = 'SCREEN_OFF';
            break;
          case ScreenStateEvent.SCREEN_UNLOCKED:
            stringState = 'SCREEN_UNLOCKED';
            break;
        }

        await storage.saveData(
          SensorData(
            type: SensorType.screenState,
            status: SendStatus.waiting,
            timestamp: DateTime.now(),
            data: {
              'state': stringState,
            },
          ),
        );
        if (parameters.showDebug == DebugLevel.verbose) {
          debugPrint('Screen state: ${state.toString()}');
        }
      },
      onError: (error) {
        if (parameters.showDebug == DebugLevel.error ||
            parameters.showDebug == DebugLevel.verbose) {
          debugPrint('Screen state error: $error');
        }
        if (error is Exception) {
          throw error;
        }
      },
    );
  }

  /// Method to start the health sensor.
  /// Requires the [parameters] and the [storage].
  /// - [parameters] is the configuration for the sensor.
  /// - [storage] is the local storage to store the data.
  /// Returns a [Future] with a [Timer].
  Future<Timer> startHealth({
    required SensorParameters parameters,
    required SensorStorage storage,
  }) async {
    if (parameters.showDebug == DebugLevel.verbose) {
      debugPrint('Starting the health service!');
    }
    return TimerUtils.createPeriodicTimer(
      fireImmediately: true,
      firstSendDelay: const Duration(
        seconds: 10,
      ),
      Duration(
        seconds: parameters.healthDataCollectionInterval,
      ),
      (timer) async {
        var useHealthConnectIfAvailable = true;

        if (Platform.isAndroid) {
          final deviceInfo = DeviceInfoPlugin();
          final androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt < 28) {
            useHealthConnectIfAvailable = false;
          }
        }
        final health = HealthFactory(
          useHealthConnectIfAvailable: useHealthConnectIfAvailable,
        );

        final healthPermission =
            await health.hasPermissions(healthTypes) ?? false;

        if (healthPermission || Platform.isIOS) {
          final now = DateTime.now();

          final healthData = await health.getHealthDataFromTypes(
            now.subtract(
              const Duration(
                days: 1,
              ),
            ),
            now,
            healthTypes,
          );

          final healthSensorData = healthData.map(
            (e) {
              if (e.value is! NumericHealthValue) {
                return SensorData(
                  type: SensorType.sleep,
                  status: SendStatus.waiting,
                  timestamp: DateTime.now(),
                  data: {
                    'date_from': e.dateFrom.toIso8601String(),
                    'date_to': e.dateTo.toIso8601String(),
                    'unit': e.unit.name,
                    'type': e.type.toString(),
                    'raw_value': e.value.toString(),
                  },
                );
              }

              final value = e.value as NumericHealthValue;

              if (parameters.showDebug == DebugLevel.verbose) {
                debugPrint('Health data: ${e.dateFrom.toIso8601String()} '
                    '- ${e.dateTo.toIso8601String()} '
                    '- ${e.type.name} '
                    '- ${value.numericValue} '
                    '- ${e.unit.name}');
              }

              return SensorData(
                type: SensorType.sleep,
                status: SendStatus.waiting,
                timestamp: DateTime.now(),
                data: {
                  'date_from': e.dateFrom.toIso8601String(),
                  'date_to': e.dateTo.toIso8601String(),
                  'unit': e.unit.name,
                  'type': e.type.name,
                  'value': value.numericValue,
                },
              );
            },
          ).toList();

          await storage.saveDataList(healthSensorData);
        }
      },
    );
  }

  /// Method to send the data to the server.
  /// Requires the [parameters], the [storage], the [dio] and the [lock].
  /// - [parameters] is the configuration for the sensor.
  /// - [storage] is the local storage to store the data.
  /// - [dio] is the HTTP client to send the data.
  /// - [lock] is the lock to synchronize the data access.
  /// Returns a [Future] with a [Timer].
  Future<Timer> sendData({
    required SensorParameters parameters,
    required SensorStorage storage,
    required Dio dio,
    required Lock lock,
  }) async {
    return TimerUtils.createPeriodicTimer(
      fireImmediately: true,
      Duration(seconds: parameters.sendDataInterval),
      (Timer timer) async {
        try {
          final data = (await storage.getData())
              .where(
                (element) => element.status == SendStatus.waiting,
              )
              .toList();

          if (data.isNotEmpty) {
            final gyroscopeData = data
                .where(
                  (element) => element.type == SensorType.gyroscope,
                )
                .toList();
            final accelerometerData = data
                .where(
                  (element) => element.type == SensorType.accelerometer,
                )
                .toList();
            final locationData = data
                .where(
                  (element) => element.type == SensorType.gps,
                )
                .toList();
            final screenStateData = data
                .where(
                  (element) => element.type == SensorType.screenState,
                )
                .toList();
            final sleepData = data
                .where(
                  (element) => element.type == SensorType.sleep,
                )
                .toList();

            var url = parameters.url;

            if (url.contains('__at_date__')) {
              final actualDate = _dateFormatter.format(DateTime.now());
              url = url.replaceAll('__at_date__', actualDate);
            }
            print("teste");
            print(url);
            Object obj = {
              'email': parameters.email,
              '${parameters.fieldsParameters.sentAtField}':
                  DateTime.now().toIso8601String(),
              '${parameters.fieldsParameters.sensorsField}': {
                if (gyroscopeData.isNotEmpty)
                  '${parameters.fieldsParameters.gyroscopeDataField}':
                      gyroscopeData
                          .map(
                            (e) => {
                              '${parameters.fieldsParameters.collectedAtField}':
                                  e.timestamp.toIso8601String(),
                              '${parameters.fieldsParameters.sensorDataField}':
                                  e.data,
                            },
                          )
                          .toList(),
                if (accelerometerData.isNotEmpty)
                  '${parameters.fieldsParameters.accelerometerDataField}':
                      accelerometerData
                          .map(
                            (e) => {
                              '${parameters.fieldsParameters.collectedAtField}':
                                  e.timestamp.toIso8601String(),
                              '${parameters.fieldsParameters.sensorDataField}':
                                  e.data,
                            },
                          )
                          .toList(),
                if (locationData.isNotEmpty)
                  '${parameters.fieldsParameters.locationDataField}':
                      locationData
                          .map(
                            (e) => {
                              '${parameters.fieldsParameters.collectedAtField}':
                                  e.timestamp.toIso8601String(),
                              '${parameters.fieldsParameters.sensorDataField}':
                                  e.data,
                            },
                          )
                          .toList(),
                if (screenStateData.isNotEmpty)
                  '${parameters.fieldsParameters.screenStateDataField}':
                      screenStateData
                          .map(
                            (e) => {
                              '${parameters.fieldsParameters.collectedAtField}':
                                  e.timestamp.toIso8601String(),
                              '${parameters.fieldsParameters.sensorDataField}':
                                  e.data,
                            },
                          )
                          .toList(),
                if (sleepData.isNotEmpty)
                  '${parameters.fieldsParameters.sleepDataField}': sleepData
                      .map(
                        (e) => {
                          '${parameters.fieldsParameters.collectedAtField}':
                              e.timestamp.toIso8601String(),
                          '${parameters.fieldsParameters.sensorDataField}':
                              e.data,
                        },
                      )
                      .toList(),
              },
            };
            print(obj);
            final response = await dio.post(
              url,
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
              data: obj,
            );

            if (parameters.showDebug == DebugLevel.verbose) {
              debugPrint('Response: ${response.data} - ${response.statusCode}');
            }

            if (response.statusCode == HttpStatus.ok) {
              await lock.synchronized(
                () => storage
                  ..updateDataList(
                    dataList: data,
                    status: SendStatus.sent,
                    lock: lock,
                  )
                  ..deleteSentData(
                    lock: lock,
                  ),
              );

              if (parameters.showDebug == DebugLevel.verbose) {
                debugPrint(
                  'Local data has been sent and deleted '
                  'from the local storage!',
                );
              }
            }
          }
        } catch (e) {
          if (parameters.showDebug == DebugLevel.error ||
              parameters.showDebug == DebugLevel.verbose) {
            debugPrint('Error: $e');
          }

          rethrow;
        }
      },
    );
  }
}
