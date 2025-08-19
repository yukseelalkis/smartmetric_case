import 'package:gen/gen.dart';

/// [AppEnvironment] is manager of environment.
final class AppEnvironment {
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  AppEnvironment.general() {
    _config = DevEnv(); // kDebugMode ? DevEnv() : ProdEnv()
  }

  static late final AppConfiguration _config;
}

/// [AppEnvironmentItems] gets the environment variables.
enum AppEnvironmentItems {
  baseUrl,
  postAuthLoginDomain,
  getCustomersDomain,
  getCustomerDetailDomain,
  postCustomersDomain,
  patchCustomersDomain;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.baseUrl:
          return AppEnvironment._config.baseUrl;
        case AppEnvironmentItems.postAuthLoginDomain:
          return AppEnvironment._config.postAuthLoginDomain;
        case AppEnvironmentItems.getCustomersDomain:
          return AppEnvironment._config.getCustomersDomain;
        case AppEnvironmentItems.getCustomerDetailDomain:
          return AppEnvironment._config.getCustomerDetailDomain;
        case AppEnvironmentItems.postCustomersDomain:
          return AppEnvironment._config.postCustomersDomain;
        case AppEnvironmentItems.patchCustomersDomain:
          return AppEnvironment._config.patchCustomersDomain;
      }
    } catch (e) {
      throw Exception('Environment variable is not found.');
    }
  }
}
