import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:sensor_med/sensor_med.dart';

part 'sensor_parameters.g.dart';

part 'sensor_parameters.freezed.dart';

/// Object to store the sensor parameters chosen by the user.
/// This is used to be able to access parameters in background services.
/// Holds the following parameters:
/// - [url] - The url to send the data to;
/// - [sendDataInterval] - The interval to send data to the server;
/// - [captureDataThrottle] - The throttle to capture data;
/// - [captureAccelerometer] - Whether to capture accelerometer data;
/// - [captureGyroscope] - Whether to capture gyroscope data;
/// - [captureLocation] - Whether to capture location data;
/// - [captureSleep] - Whether to capture sleep data;
/// - [captureScreenState] - Whether to capture screen state data;
/// - [showDebug] - The debug level to show;
/// - [healthDataCollectionInterval] - The interval to collect health data;
/// - [fieldsParameters] - The parameters for the fields to capture,
/// see [FieldsParameters].
/// - [email] - email,
@freezed
class SensorParameters with _$SensorParameters {
  /// Object to store the sensor parameters chosen by the user.
  /// This is used to be able to access parameters in background services.
  /// Holds the following parameters:
  /// - [url] - The url to send the data to;
  /// - [sendDataInterval] - The interval to send data to the server;
  /// - [captureDataThrottle] - The throttle to capture data;
  /// - [captureAccelerometer] - Whether to capture accelerometer data;
  /// - [captureGyroscope] - Whether to capture gyroscope data;
  /// - [captureLocation] - Whether to capture location data;
  /// - [captureSleep] - Whether to capture sleep data;
  /// - [captureScreenState] - Whether to capture screen state data;
  /// - [showDebug] - The debug level to show;
  /// - [healthDataCollectionInterval] - The interval to collect health data;
  /// - [email] - email,
  /// - [fieldsParameters] - The parameters for the fields to capture,
  /// see [FieldsParameters].
  @HiveType(typeId: 0, adapterName: 'SensorParametersAdapter')
  const factory SensorParameters(
      {@HiveField(0) required String url,
      @HiveField(1) @Default(5) int sendDataInterval,
      @HiveField(2) @Default(100) int captureDataThrottle,
      @HiveField(3) @Default(true) bool captureAccelerometer,
      @HiveField(4) @Default(true) bool captureGyroscope,
      @HiveField(5) @Default(true) bool captureLocation,
      @HiveField(6) @Default(true) bool captureSleep,
      @HiveField(7) @Default(true) bool captureScreenState,
      @HiveField(8) @Default(DebugLevel.none) DebugLevel showDebug,
      @HiveField(9) @Default(86400) int healthDataCollectionInterval,
      @HiveField(10)
      @Default(FieldsParameters())
      FieldsParameters fieldsParameters,
      @HiveField(11) @Default('') String email}) = _SensorParameters;

  /// Factory constructor to create a SensorParameters object.
  /// Create a SensorParameters object from a json object.
  factory SensorParameters.fromJson(Map<String, dynamic> json) =>
      _$SensorParametersFromJson(json);
}
