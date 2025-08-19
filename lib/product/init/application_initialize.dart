import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:smartmetric_case/product/init/cache/cache_manager.dart';
import 'package:smartmetric_case/product/init/config/app_environment.dart';

/// [ApplicationInitialize] is a class that initializes the application.
@immutable
final class ApplicationInitialize {
  /// Ensures Flutter is initialized and runs `_initialize`, logging any errors.
  Future<void> make() async {
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      Logger().e('Error: $error\nStack: $stack');
    });
  }

  /// [_initialize] is a method that initializes the application.
  Future<void> _initialize() async {
    /// Initialize Easy Localization
    await EasyLocalization.ensureInitialized();

    EasyLocalization.logger.enableLevels = [LevelMessages.error];

    /// Lock orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// Global Flutter error logging
    FlutterError.onError = (details) {
      Logger().e('Flutter Error: ${details.exception}');
    };

    /// Load environment configs
    AppEnvironment.general();

    /// Init cache
    await CacheManager.instance.init();
  }
}
