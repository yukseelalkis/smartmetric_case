import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smartmetric_case/feature/view/auth/login_view.dart';
import 'package:smartmetric_case/feature/view/auth/sign_up_view.dart';
import 'package:smartmetric_case/product/init/application_initialize.dart';
import 'package:smartmetric_case/product/init/language/product_localization.dart';
import 'package:smartmetric_case/product/init/theme/decided_the_theme.dart';
import 'package:smartmetric_case/product/utility/constant/enums/smartmetric.dart';

Future<void> main() async {
  // Binding mutlaka en başta olmalı
  WidgetsFlutterBinding.ensureInitialized();

  // Uygulama initialize
  await ApplicationInitialize().make();

  // Uygulama localization + runApp
  runApp(
    ProductLocalization(
      child: const SmartMetricsCase(),
    ),
  );
}

class SmartMetricsCase extends StatelessWidget {
  const SmartMetricsCase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Smartmetrics.smartmetric.name,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: DecidedTheTheme.themeConfiguration(context),
      home: const LoginView(),
    );
  }
}
