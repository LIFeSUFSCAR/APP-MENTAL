library sensor_med;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensor_med/model/debug_level.dart';
import 'package:sensor_med/model/fields_parameters.dart';
import 'package:sensor_med/model/sensor_parameters.dart';
import 'package:sensor_med/util/background_service.dart';
import 'package:sensor_med/util/exceptions.dart';
import 'package:sensor_med/util/sensor_storage.dart';
import 'package:sensor_med/util/sensors_manager.dart';

export 'package:sensor_med/model/debug_level.dart';
export 'package:sensor_med/model/fields_parameters.dart';
export 'package:sensor_med/util/exceptions.dart';

/// SensorMed is a singleton class that provides methods to start and stop the
/// sensors service.
/// The sensors service captures the accelerometer, gyroscope, location, sleep,
/// and screen state data and sends it to the specified URL.
/// The service can be started and stopped using the [startSensorsService] and
/// [stopSensorsService] methods respectively.
/// The [isSensorsServiceRunning] method can be used to check if the service is
/// running.
class SensorMed {
  /// SensorMed is a singleton class that provides methods to start and stop the
  /// sensors service.
  /// The sensors service captures the accelerometer, gyroscope, location,
  /// sleep, and screen state data and sends it to the specified URL.
  /// The service can be started and stopped using the [startSensorsService] and
  /// [stopSensorsService] methods respectively.
  /// The [isSensorsServiceRunning] method can be used to check if the service
  /// is running.
  factory SensorMed() {
    return _instance;
  }

  SensorMed._();

  static final SensorMed _instance = SensorMed._();

  /// Returns the singleton instance of the SensorMed class.
  static SensorMed get instance => _instance;

  /// Starts the sensors service.
  /// Holds the following parameters:
  /// - [url] - The URL to which the data will be sent.
  /// - [captureAccelerometer] - Whether to capture accelerometer data.
  /// - [captureGyroscope] - Whether to capture gyroscope data.
  /// - [captureLocation] - Whether to capture location data.
  /// - [captureSleep] - Whether to capture sleep data.
  /// - [captureScreenState] - Whether to capture screen state data.
  /// - [sendDataInterval] - The interval at which the data will be sent.
  /// - [captureDataThrottle] - The throttle duration for capturing data.
  /// - [healthDataCollectionInterval] - The interval at which health data will be
  /// collected.
  /// - [showDebug] - The debug level to show.
  /// - [fieldsParameters] - The parameters to be sent with the data.
  ///
  /// On starting the service, the following permissions are requested based on
  /// capture data requested by the user:
  /// - Location
  /// - Location Always
  /// - Health
  ///
  /// Throws the following exceptions:
  /// - If the URL is empty, an [InvalidSendDataUrlException] is thrown.
  /// - If the location service is disabled, a [LocationServiceDisabledException]
  /// is thrown.
  /// - If the location permission is denied, a [LocationDeniedException]
  /// is thrown.
  /// - If the health permission is denied, a [HealthPermissionDeniedException]
  /// is thrown.
  Future<void> startSensorsService(
      {required String url,
      bool captureAccelerometer = true,
      bool captureGyroscope = true,
      bool captureLocation = true,
      bool captureSleep = true,
      bool captureScreenState = true,
      Duration sendDataInterval = const Duration(seconds: 5),
      Duration captureDataThrottle = const Duration(milliseconds: 100),
      Duration healthDataCollectionInterval = const Duration(
        days: 1,
      ),
      DebugLevel showDebug = kDebugMode ? DebugLevel.error : DebugLevel.none,
      FieldsParameters? fieldsParameters,
      String email = ''}) async {
    final directory = await getApplicationDocumentsDirectory();
    final storage = await SensorStorage.create(
      directory: directory,
    );
    final sensorsManager = SensorsManager();

    if (captureLocation) {
      final locationServiceStatus =
          await Permission.locationWhenInUse.serviceStatus;
      final locationPermissionStatus =
          await Permission.locationWhenInUse.request();

      if (locationServiceStatus != ServiceStatus.enabled &&
          locationServiceStatus != ServiceStatus.notApplicable) {
        throw LocationServiceDisabledException();
      }

      if (locationPermissionStatus != PermissionStatus.granted) {
        final locationPermissionStatus =
            await Permission.locationWhenInUse.request();
        if (locationPermissionStatus != PermissionStatus.granted) {
          throw LocationDeniedException();
        }
      }

      await Permission.locationAlways.request();
    }

    if (captureSleep) {
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

      var hasPermissions = true;

      if (Platform.isAndroid) {
        hasPermissions =
            await health.hasPermissions(sensorsManager.healthTypes) ?? false;
      }

      if (Platform.isIOS || !hasPermissions) {
        final permissions =
            await health.requestAuthorization(sensorsManager.healthTypes);

        if (!permissions) {
          final permissions = await health.requestAuthorization(
            sensorsManager.healthTypes,
          );
          if (!permissions) {
            throw HealthPermissionDeniedException();
          }
        }
      }
    }

    if (url.isEmpty) {
      throw InvalidSendDataUrlException();
    }

    await storage.saveParameters(
      SensorParameters(
          url: url,
          sendDataInterval: sendDataInterval.inSeconds,
          captureDataThrottle: captureDataThrottle.inMilliseconds,
          captureAccelerometer: captureAccelerometer,
          captureGyroscope: captureGyroscope,
          captureLocation: captureLocation,
          captureSleep: captureSleep,
          captureScreenState: captureScreenState,
          showDebug: showDebug,
          healthDataCollectionInterval: healthDataCollectionInterval.inSeconds,
          fieldsParameters: fieldsParameters ?? const FieldsParameters(),
          email: email),
    );
    await startBackgroundService();
  }

  /// Stops the sensors service.
  Future<void> stopSensorsService() async {
    await stopBackgroundService();
  }

  /// Returns whether the sensors service is running.
  Future<bool> isSensorsServiceRunning() async {
    return isBackgroundServiceRunning();
  }
}
