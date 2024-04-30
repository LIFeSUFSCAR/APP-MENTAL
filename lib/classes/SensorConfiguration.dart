import 'dart:ffi';

class SensorConfiguration {
  int? id;
  final String userEmail;
  final int accelerometer;
  final int gyroscope;
  final int location;

  SensorConfiguration(
      {this.id,
      required this.userEmail,
      required this.accelerometer,
      required this.gyroscope,
      required this.location});

  factory SensorConfiguration.fromMap(Map<String, dynamic> json) =>
      SensorConfiguration(
          id: json['id'],
          userEmail: json['userEmail'],
          accelerometer: json['accelerometer'],
          gyroscope: json['gyroscope'],
          location: json['location']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'accelerometer': accelerometer,
      'gyroscope': gyroscope,
      'location': location
    };
  }
}
