// lib/product/navigation/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:smartmetric_case/feature/view/auth/login_view.dart';
import 'package:smartmetric_case/feature/view/auth/sign_up_view.dart';
import 'package:smartmetric_case/feature/view/common/customer_detail_view.dart';
import 'package:smartmetric_case/feature/view/home/home_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // İlk ekran Login
        AutoRoute(page: LoginRoute.page, initial: true),

        // Login'den signup geçişi
        AutoRoute(page: SignUpRoute.page),

        // Başarılı login sonrası Home
        AutoRoute(page: HomeRoute.page),

        // Home içinden detay
        AutoRoute(page: CustomerDetailRoute.page),
      ];
}
