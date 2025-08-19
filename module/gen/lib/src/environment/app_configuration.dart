/// [AppConfiguration] is an abstract class that contains
/// the configuration variables of the application.
abstract class AppConfiguration {
  /// [baseUrl] is the base url of the application.
  String get baseUrl;

  /// [postAuthLoginDomain] is the domain for the post auth login.
  String get postAuthLoginDomain;

  /// [getCustomersDomain] is the domain for getting customer list.
  String get getCustomersDomain;

  /// [getCustomerDetailDomain] is the domain for getting a single customer detail.
  String get getCustomerDetailDomain;

  /// [postCustomersDomain] is the domain for creating a new customer.
  String get postCustomersDomain;

  /// [patchCustomersDomain] is the domain for updating an existing customer.
  String get patchCustomersDomain;
}
