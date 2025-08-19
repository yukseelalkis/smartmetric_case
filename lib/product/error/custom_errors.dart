import 'package:easy_localization/easy_localization.dart';
import 'package:smartmetric_case/product/init/language/locale_keys.g.dart';

/// [SharedNotInitializeException] is a class that handle the exception when
/// the shared preferences didn't initialize right now
final class SharedNotInitializeException implements Exception {
  @override
  String toString() => LocaleKeys.error_your_preferences_did_not_init_now.tr();
}
