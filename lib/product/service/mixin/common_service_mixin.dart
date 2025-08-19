import 'package:dio/dio.dart';
import 'package:gen/gen.dart';

/// [CommonServiceMixin] is a mixin class that contains common methods
mixin CommonServiceMixin {
  /// Domains that require token to be added
  final _domainsToAddToken = [
    DevEnv().getCustomersDomain,
    DevEnv().getCustomerDetailDomain,
    DevEnv().postCustomersDomain,
    DevEnv().patchCustomersDomain,
  ];

  /// [shouldAddToken] method is used to check if the token should be added to the request.
  bool shouldAddToken({
    required RequestOptions options,
  }) =>
      _domainsToAddToken.any(
        (domain) {
          final requestUrl = '${DevEnv().baseUrl}$domain';
          return requestUrl.contains(options.path);
        },
      );
}
