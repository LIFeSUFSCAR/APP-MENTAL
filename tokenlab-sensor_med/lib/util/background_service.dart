import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sensor_med/model/debug_level.dart';
import 'package:sensor_med/model/sensor_parameters.dart';
import 'package:sensor_med/util/background_manager.dart';
import 'package:sensor_med/util/sensor_storage.dart';

/// Start the background service
/// This function is called when the app is in the foreground
/// and the background service is not running
/// It starts the background service and sends the data to the server
/// The data is sent to the server
/// every [SensorParameters.sendDataInterval] seconds.
/// The data is sent to the server only if the app is in the background
/// and the background service is running.
/// If a error occurs, the background service never stops and
/// the error is logged in the console.
Future<void> startBackgroundService() async {
  final service = FlutterBackgroundService();
  final directory = await getApplicationDocumentsDirectory();
  final storage = await SensorStorage.create(
    directory: directory,
  );
  final parameters = await storage.getParameters() ??
      const SensorParameters(
        url: '',
      );

  if (parameters.showDebug == DebugLevel.verbose) {
    debugPrint('Starting the background service!');
  }

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIOSStart,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      autoStartOnBoot: true,
      isForegroundMode: true,
      onStart: onStart,
    ),
  );

  if (!await service.isRunning()) {
    await service.startService();
  }
}

/// Stop the background service.
/// This function is called when the app is in the background
/// and the background service is running.
/// It stops the background service.
Future<void> stopBackgroundService() async {
  final service = FlutterBackgroundService();
  final directory = await getApplicationDocumentsDirectory();
  final storage = await SensorStorage.create(
    directory: directory,
  );
  final parameters = await storage.getParameters() ??
      const SensorParameters(
        url: '',
      );

  if (await service.isRunning()) {
    service.invoke('stopService');
  }

  if (parameters.showDebug == DebugLevel.verbose) {
    debugPrint('Stopping the background service!');
  }
}

/// Check if the background service is running.
Future<bool> isBackgroundServiceRunning() async {
  final service = FlutterBackgroundService();
  return await service.isRunning();
}
