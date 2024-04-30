import 'package:hive/hive.dart';

part 'sensor_type.g.dart';

/// Enum to represent the type of sensor.
/// Holds the following types:
/// - [gyroscope] - Gyroscope sensor;
/// - [accelerometer] - Accelerometer sensor;
/// - [screenState] - Screen state sensor;
/// - [sleep] - Sleep sensor;
/// - [gps] - GPS sensor.
@HiveType(typeId: 3)
enum SensorType {
  /// Gyroscope sensor.
  @HiveField(0)
  gyroscope,

  /// Accelerometer sensor.
  @HiveField(1)
  accelerometer,

  /// Screen state sensor.
  @HiveField(2)
  screenState,

  /// Sleep sensor.
  @HiveField(3)
  sleep,

  /// GPS sensor.
  @HiveField(4)
  gps,
}
