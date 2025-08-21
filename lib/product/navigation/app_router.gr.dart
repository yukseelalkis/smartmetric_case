// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CustomerDetailView]
class CustomerDetailRoute extends PageRouteInfo<CustomerDetailRouteArgs> {
  CustomerDetailRoute({
    Key? key,
    required String customerName,
    required int customId,
    Customer? fallback,
    List<PageRouteInfo>? children,
  }) : super(
          CustomerDetailRoute.name,
          args: CustomerDetailRouteArgs(
            key: key,
            customerName: customerName,
            customId: customId,
            fallback: fallback,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomerDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return CustomerDetailView(
        key: args.key,
        customerName: args.customerName,
        customId: args.customId,
        fallback: args.fallback,
      );
    },
  );
}

class CustomerDetailRouteArgs {
  const CustomerDetailRouteArgs({
    this.key,
    required this.customerName,
    required this.customId,
    this.fallback,
  });

  final Key? key;

  final String customerName;

  final int customId;

  final Customer? fallback;

  @override
  String toString() {
    return 'CustomerDetailRouteArgs{key: $key, customerName: $customerName, customId: $customId, fallback: $fallback}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginView();
    },
  );
}

/// generated route for
/// [SignUpView]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpView();
    },
  );
}
