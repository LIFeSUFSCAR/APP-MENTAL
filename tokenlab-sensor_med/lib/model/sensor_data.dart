import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:sensor_med/model/send_status.dart';
import 'package:sensor_med/model/sensor_type.dart';

part 'sensor_data.g.dart';

part 'sensor_data.freezed.dart';

/// Class used to capture generic sensor data.
/// Holds the following fields:
/// - [type] - type of sensor;
/// - [status] - status of the data (sent or not);
/// - [timestamp] - time when the data was captured;
/// - [data] - the actual data captured by the sensor.
@freezed
class SensorData with _$SensorData {
  /// Class used to capture generic sensor data.
  /// Holds the following fields:
  /// - [type] - type of sensor;
  /// - [status] - status of the data (sent or not);
  /// - [timestamp] - time when the data was captured;
  /// - [data] - the actual data captured by the sensor.
  @HiveType(typeId: 1, adapterName: 'SensorDataAdapter')
  const factory SensorData({
    @HiveField(0) required SensorType type,
    @HiveField(1) required SendStatus status,
    @HiveField(2) required DateTime timestamp,
    @HiveField(3) required dynamic data,
  }) = _SensorData;

  /// Factory constructor for SensorData
  /// Used to integrate freezed with json_serializable
  factory SensorData.fromJson(Map<String, dynamic> json) =>
      _$SensorDataFromJson(json);
}
