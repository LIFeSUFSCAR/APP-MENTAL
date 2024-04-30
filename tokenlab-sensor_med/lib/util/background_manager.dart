import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_state/screen_state.dart';
import 'package:sensor_med/model/debug_level.dart';
import 'package:sensor_med/model/sensor_parameters.dart';
import 'package:sensor_med/util/sensor_storage.dart';
import 'package:sensor_med/util/sensors_manager.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Starts the sensors service in the background.
/// Holds the following parameters:
/// - [instance] - The instance of the service.
///
/// The method starts the sensors service and listens for the stopService event.
/// When the stopService event is received, the method stops the sensors
/// service.
/// The method also ensures that the sensors service is initialized and the
/// widgets are bound.
/// The method is marked with the pragma vm:entry-point to indicate that it is
/// the entry point for the background service.
@pragma('vm:entry-point')
void onStart(ServiceInstance instance) async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  instance.invoke('stopService');

  final directory = await getApplicationDocumentsDirectory();
  final dio = Dio();
  final lock = SensorStorage.lock;
  final sensorsManager = SensorsManager();

  final storage = await SensorStorage.create(
    directory: directory,
  );

  final parameters = await storage.getParameters() ??
      const SensorParameters(
        url: '',
      );

  StreamSubscription<GyroscopeEvent>? gyroscope;
  StreamSubscription<UserAccelerometerEvent>? accelerometer;
  StreamSubscription<Position>? location;
  StreamSubscription<ScreenStateEvent>? screenState;
  Timer? healthTimer;
  Timer? sendTimer;

  if (parameters.captureGyroscope) {
    gyroscope = await sensorsManager.startGyroscope(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureAccelerometer) {
    accelerometer = await sensorsManager.startAccelerometer(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureLocation) {
    location = await sensorsManager.startLocation(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureScreenState) {
    screenState = await sensorsManager.startScreenState(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureSleep) {
    healthTimer = await sensorsManager.startHealth(
      parameters: parameters,
      storage: storage,
    );
  }

  // TODO(any): Ativar e configurar o envio de dados
  sendTimer = await sensorsManager.sendData(
    parameters: parameters,
    storage: storage,
    dio: dio,
    lock: lock,
  );

  instance.on('stopService').listen(
    (event) {
      gyroscope?.cancel();
      accelerometer?.cancel();
      location?.cancel();
      screenState?.cancel();
      healthTimer?.cancel();
      sendTimer?.cancel();
      instance.stopSelf();
      if (parameters.showDebug == DebugLevel.verbose) {
        debugPrint('The background service has been stopped!');
      }
    },
  );
}

/// Starts the sensors service in the background on iOS.
/// Holds the following parameters:
/// - [instance] - The instance of the service.
///
/// The method starts the sensors service and listens for the stopService event.
/// When the stopService event is received, the method stops the sensors
/// service.
/// The method also ensures that the sensors service is initialized and the
/// widgets are bound.
/// The method returns true if the service is started successfully.
/// The method is marked with the pragma vm:entry-point to indicate that it is
/// the entry point for the background service on iOS.
@pragma('vm:entry-point')
Future<bool> onIOSStart(ServiceInstance instance) async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  instance.invoke('stopService');

  final directory = await getApplicationDocumentsDirectory();
  final dio = Dio();
  final lock = SensorStorage.lock;
  final sensorsManager = SensorsManager();

  final storage = await SensorStorage.create(
    directory: directory,
  );

  final parameters = await storage.getParameters() ??
      const SensorParameters(
        url: '',
      );

  StreamSubscription<GyroscopeEvent>? gyroscope;
  StreamSubscription<UserAccelerometerEvent>? accelerometer;
  StreamSubscription<Position>? location;
  StreamSubscription<ScreenStateEvent>? screenState;
  Timer? healthTimer;
  Timer? sendTimer;

  if (parameters.captureGyroscope) {
    gyroscope = await sensorsManager.startGyroscope(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureAccelerometer) {
    accelerometer = await sensorsManager.startAccelerometer(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureLocation) {
    location = await sensorsManager.startLocation(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureScreenState) {
    screenState = await sensorsManager.startScreenState(
      parameters: parameters,
      storage: storage,
    );
  }

  if (parameters.captureSleep) {
    healthTimer = await sensorsManager.startHealth(
      parameters: parameters,
      storage: storage,
    );
  }

  // TODO(any): Ativar e configurar o envio de dados
  sendTimer = await sensorsManager.sendData(
    parameters: parameters,
    storage: storage,
    dio: dio,
    lock: lock,
  );

  instance.on('stopService').listen(
    (event) {
      gyroscope?.cancel();
      accelerometer?.cancel();
      location?.cancel();
      screenState?.cancel();
      healthTimer?.cancel();
      sendTimer?.cancel();
      instance.stopSelf();
      if (parameters.showDebug == DebugLevel.verbose) {
        debugPrint('The background service has been stopped!');
      }
    },
  );
  return true;
}
