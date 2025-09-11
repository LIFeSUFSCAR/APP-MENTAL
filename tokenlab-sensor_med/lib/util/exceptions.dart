/// This class is used to handle all the exceptions that can be thrown by
/// the library. It is used to handle the exceptions in a more organized way.
abstract class SensorMedException implements Exception {}

/// This exception is thrown when the user denies the permission to access the
/// location of the device.
class LocationDeniedException implements SensorMedException {}

/// This exception is thrown when the location service is disabled on the
/// device.
class LocationServiceDisabledException implements SensorMedException {}

/// This exception is thrown when the user denies the permission to access the
/// health data of the device.
class HealthPermissionDeniedException implements SensorMedException {}

/// This exception is thrown when the user denies the permission to access the
/// activity data of the device.
class InvalidSendDataUrlException implements SensorMedException {}
