import 'package:logger/logger.dart';
import 'package:common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmetric_case/product/error/custom_errors.dart';
import 'package:smartmetric_case/product/utility/constant/enums/cache_allow_list.dart';

/// [CacheManager] is the cache manager of the app using SharedPreferencesWithCache
/// We can use like that: await CacheManager.instance.setString('key', value: 'value');
/// We can use like that: CacheManager.instance.getString('key');
final class CacheManager {
  CacheManager._();

  static final CacheManager _instance = CacheManager._();

  /// [instance] is the instance of [CacheManager]
  static CacheManager get instance => _instance;

  SharedPreferencesWithCache? _sharedPreferencesWithCache;

  void _checkPreferences() {
    if (!_sharedPreferencesWithCache.hasValue) {
      throw SharedNotInitializeException();
    }
  }

  /// [init] initializes SharedPreferencesWithCache
  Future<void> init() async {
    _sharedPreferencesWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: CacheAllowListEnum.allowList,
      ),
    );
  }

  /// [setString] sets a string value to the shared preferences
  Future<void> setString(String key, {required String value}) async {
    try {
      _checkPreferences();
      await _sharedPreferencesWithCache!.setString(key, value);
    } catch (e) {
      Logger(level: Level.error).e(e);
    }
  }

  /// [getString] gets a string value from the shared preferences
  String? getString(String key) {
    try {
      _checkPreferences();
      return _sharedPreferencesWithCache!.getString(key);
    } catch (e) {
      Logger(level: Level.error).e(e);
      return null;
    }
  }

  /// [setBool] sets a boolean value to the shared preferences
  Future<void> setBool(String key, {required bool value}) async {
    try {
      _checkPreferences();
      await _sharedPreferencesWithCache!.setBool(key, value);
    } catch (e) {
      Logger(level: Level.error).e(e);
    }
  }

  /// [getBool] gets a boolean value from the shared preferences
  bool? getBool(String key) {
    try {
      _checkPreferences();
      return _sharedPreferencesWithCache!.getBool(key);
    } catch (e) {
      Logger(level: Level.error).e(e);
      return null;
    }
  }

  /// [clearSP] clears all shared preferences
  Future<void> clearSP() async {
    _checkPreferences();
    await _sharedPreferencesWithCache!.clear();
  }
}
