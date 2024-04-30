import 'package:hive/hive.dart';

part 'send_status.g.dart';

/// Enum to control the status of the message.
/// Holds the following values:
/// - [Waiting]: The message is waiting to be sent;
/// - [Sent]: The message was sent and able to be deleted.
@HiveType(typeId: 2)
enum SendStatus {
  /// The message is waiting to be sent
  @HiveField(0)
  waiting,

  /// The message was sent and able to be deleted
  @HiveField(1)
  sent,
}
