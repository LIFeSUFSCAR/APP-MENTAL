import 'dart:async';

/// Utility class for creating timers.
class TimerUtils {

  /// Create a periodic timer that can fires immediately.
  static Timer createPeriodicTimer(
    Duration duration,
    void Function(Timer timer) callback, {
    bool fireImmediately = false,
    Duration? firstSendDelay,
  }) {
    if (fireImmediately) {
      Future.delayed(
        firstSendDelay ?? Duration.zero,
        () {
          callback.call(Timer(Duration.zero, () {}));
        },
      );
    }
    return Timer.periodic(duration, callback);
  }
}
