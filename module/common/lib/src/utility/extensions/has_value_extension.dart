/// [HasValueExtension] is an extension class to check if the value is
/// null, empty, or undefined.
extension HasValueExtension on Object? {
  /// [hasValue] checks if the object is not null, not empty,
  /// and not invalid based on its type.
  /// Supports String, List, Map, Set, Iterable, and custom types.
  /// For numbers, it considers 0 as having a value but allows extensibility
  /// for other checks.
  bool get hasValue {
    if (this == null) return false;

    if (this is String) return (this! as String).trim().isNotEmpty;
    if (this is List) return (this! as List).isNotEmpty;
    if (this is Map) return (this! as Map).isNotEmpty;
    if (this is Set) return (this! as Set).isNotEmpty;
    if (this is Iterable) return (this! as Iterable).isNotEmpty;
    // Numbers are considered to always have a value (even if 0).
    if (this is num) return true;

    if (this is bool) return true; // Booleans always have a value (true/false).

    // Optional: Add custom type checks if necessary.
    // Example: For custom classes, you can override `toString` or
    // define specific rules.
    if (this is CustomValidatable) {
      return (this! as CustomValidatable).isValid;
    }

    return true; // Default for other object types.
  }

  /// [isNullOrEmpty] checks if the object is null or empty for supported types.
  /// Useful for quick null or empty checks without additional typecasting.
  bool get isNullOrEmpty {
    return !hasValue;
  }

  /// [isBlank] considers null, empty strings,
  /// or strings with only whitespace as blank.
  /// For other types, it defers to [isNullOrEmpty].
  bool get isBlank {
    if (this is String) {
      return (this! as String).trim().isEmpty;
    }
    return isNullOrEmpty;
  }

  /// [toNonNullValue] returns a non-null default value
  /// if the current value is null.
  /// For Strings, Lists, and Maps, it returns an empty instance by default.
  /// For numbers, it returns 0.
  T toNonNullValue<T>(T defaultValue) {
    if (this == null) return defaultValue;
    if (this is T) return this as T;
    return defaultValue;
  }

  /// [isOfType] checks if the object is of a specific type dynamically.
  /// Example: `value.isOfType<String>()`
  bool isOfType<T>() {
    return this is T;
  }

  /// [isFalsy] checks if the object can be considered as
  /// "falsy" (null, empty, or zero-like).
  bool get isFalsy {
    if (this == null) return true;
    if (this is String && (this! as String).trim().isEmpty) return true;
    if (this is List && (this! as List).isEmpty) return true;
    if (this is Map && (this! as Map).isEmpty) return true;
    if (this is Set && (this! as Set).isEmpty) return true;
    if (this is num && this == 0) return true;
    return false;
  }

  /// [isTruthy] is the opposite of [isFalsy].
  bool get isTruthy => !isFalsy;
}

/// [CustomValidatable] is an abstract class for custom validation checks.
abstract class CustomValidatable {
  /// [isValid] is a getter that returns the validation status.
  bool get isValid;
}
