import 'package:hive/hive.dart';

part 'debug_level.g.dart';

/// Enum to select the debug level
/// Holds the following values:
/// - [none]: No debug messages;
/// - [error]: Only error messages;
/// - [verbose]: All messages.
@HiveType(typeId: 4)
enum DebugLevel {
  /// Don't show any debug messages.
  @HiveField(0)
  none,

  /// Only show error messages.
  @HiveField(1)
  error,

  /// Show all messages for debugging.
  @HiveField(2)
  verbose,
}
