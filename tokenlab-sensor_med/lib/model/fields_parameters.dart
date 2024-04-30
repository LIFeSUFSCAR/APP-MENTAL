import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'fields_parameters.g.dart';

part 'fields_parameters.freezed.dart';

/// Object to store the fields parameters chosen by the user.
/// This is used to be able to access parameters in background services.
/// Holds the following fields:
/// - [sentAtField] - The field name for the sentAt field;
/// - [sensorsField] - The field name for the sensors field;
/// - [gyroscopeDataField] - The field name for the gyroscopeData field;
/// - [accelerometerDataField] - The field name for the accelerometerData field;
/// - [locationDataField] - The field name for the locationData field;
/// - [sleepDataField] - The field name for the sleepData field;
/// - [screenStateDataField] - The field name for the screenStateData field;
/// - [collectedAtField] - The field name for the collectedAt field;
/// - [sensorDataField] - The field name for the sensorData field.
@freezed
class FieldsParameters with _$FieldsParameters {
  /// Object to store the fields parameters chosen by the user.
  /// This is used to be able to access parameters in background services.
  /// Holds the following fields:
  /// - [sentAtField] - The field name for the sentAt field;
  /// - [sensorsField] - The field name for the sensors field;
  /// - [gyroscopeDataField] - The field name for the gyroscopeData field;
  /// - [accelerometerDataField] - The field name for the accelerometerData field;
  /// - [locationDataField] - The field name for the locationData field;
  /// - [sleepDataField] - The field name for the sleepData field;
  /// - [screenStateDataField] - The field name for the screenStateData field;
  /// - [collectedAtField] - The field name for the collectedAt field;
  /// - [sensorDataField] - The field name for the sensorData field.
  @HiveType(typeId: 5, adapterName: 'FieldsParametersAdapter')
  const factory FieldsParameters({
    @HiveField(0) @Default('sentAt') String sentAtField,
    @HiveField(1) @Default('sensors') String sensorsField,
    @HiveField(2) @Default('gyroscopeData') String gyroscopeDataField,
    @HiveField(3) @Default('accelerometerData') String accelerometerDataField,
    @HiveField(4) @Default('locationData') String locationDataField,
    @HiveField(5) @Default('sleepData') String sleepDataField,
    @HiveField(6) @Default('screenStateData') String screenStateDataField,
    @HiveField(7) @Default('collectedAt') String collectedAtField,
    @HiveField(8) @Default('data') String sensorDataField,
  }) = _FieldsParameters;

  /// Factory constructor for fields parameters to convert a json object
  /// to a FieldsParameters object
  factory FieldsParameters.fromJson(Map<String, dynamic> json) =>
      _$FieldsParametersFromJson(json);
}
