import 'package:envied/envied.dart';
import 'package:gen/src/environment/app_configuration.dart';

part 'dev_env.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.dev.env',
)

/// [DevEnv] is a class that is used to get the environment variables.
final class DevEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _DevEnv._baseUrl;

  @EnviedField(varName: 'POST_AUTH_LOGIN_DOMAIN')
  static final String _postAuthLoginDomain = _DevEnv._postAuthLoginDomain;

  @EnviedField(varName: 'GET_CUSTOMERS_DOMAIN')
  static final String _getCustomersDomain = _DevEnv._getCustomersDomain;

  @EnviedField(varName: 'GET_CUSTOMER_DETAIL_DOMAIN')
  static final String _getCustomerDetailDomain =
      _DevEnv._getCustomerDetailDomain;

  @EnviedField(varName: 'POST_CUSTOMERS_DOMAIN')
  static final String _postCustomersDomain = _DevEnv._postCustomersDomain;

  @EnviedField(varName: 'PATCH_CUSTOMERS_DOMAIN')
  static final String _patchCustomersDomain = _DevEnv._patchCustomersDomain;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get postAuthLoginDomain => _postAuthLoginDomain;

  @override
  String get getCustomersDomain => _getCustomersDomain;

  @override
  String get getCustomerDetailDomain => _getCustomerDetailDomain;

  @override
  String get postCustomersDomain => _postCustomersDomain;

  @override
  String get patchCustomersDomain => _patchCustomersDomain;
}
