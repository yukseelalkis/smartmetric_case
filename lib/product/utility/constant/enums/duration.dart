/// [DurationSeconds] enum is used to define as second the duration of the application.
enum DurationSeconds {
  /// [veryShort] mean 1 second.
  veryShort,

  /// [short] mean 2 seconds.
  short,

  /// [medium] mean 5 seconds.
  medium,

  /// [long] mean 7 seconds.
  long,

  /// [veryLong] mean 10 seconds.
  veryLong;

  /// [value] is used to get the value of the enum.
  int get value {
    switch (this) {
      case DurationSeconds.veryShort:
        return 1;
      case DurationSeconds.short:
        return 3;
      case DurationSeconds.medium:
        return 5;
      case DurationSeconds.long:
        return 7;
      case DurationSeconds.veryLong:
        return 10;
      default:
        return 1;
    }
  }
}

/// [DurationMiliSeconds] enum is used to define as mili second the duration of
/// the application.
enum DurationMiliSeconds {
  /// [veryShort] mean 100 mili second.
  veryShort,

  /// [short] mean 200 mili second.
  short,

  /// [medium] mean 500 mili second.
  medium,

  /// [long] mean 700 mili second.
  long,

  /// [veryLong] mean 1000 mili second.
  veryLong;

  /// [value] is used to get the value of the enum.
  int get value {
    switch (this) {
      case DurationMiliSeconds.veryShort:
        return 100;
      case DurationMiliSeconds.short:
        return 200;
      case DurationMiliSeconds.medium:
        return 500;
      case DurationMiliSeconds.long:
        return 700;
      case DurationMiliSeconds.veryLong:
        return 1000;
      default:
        return 100;
    }
  }
}
