// import 'dart:developer';

// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:common/common.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gen/gen.dart';
// import 'package:logger/logger.dart';
// import 'package:smartmetric_case/feature/view/home/home_view.dart';
// import 'package:smartmetric_case/feature/view/mixin/auth/auth_common_view_mixin.dart';
// import 'package:smartmetric_case/feature/view/mixin/auth/login_view_mixin.dart';
// import 'package:smartmetric_case/feature/view/mixin/common_view_mixin.dart';
// import 'package:smartmetric_case/feature/view/transparent_view.dart';
// import 'package:smartmetric_case/feature/view/widget/custom_snackbar.dart';
// import 'package:smartmetric_case/feature/viewmodel/login_view_model.dart';
// import 'package:smartmetric_case/product/state/login_state.dart';
// import 'package:smartmetric_case/product/utility/constant/enums/response_type.dart';

// import '../../../product/init/language/locale_keys.g.dart';

// /// [LoginView] is a class that contains the login view.
// @RoutePage()
// final class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// final class _LoginViewState extends State<LoginView>
//     with AuthCommonViewMixin, LoginViewMixin, DeviceSizeMixin, CommonViewMixin {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => loginViewModel,
//       child: GestureDetector(
//         onTap: () => gestureOnTap(context),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: SafeArea(
//             child: Stack(
//               children: [
//                 Padding(
//                   padding:
//                       PaddingManager.normalPaddingSymmetricHorizontal(context),
//                   child: Form(
//                     key: loginFormKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Spacer(flex: 1),
//                         Expanded(
//                           child: Column(
//                             children: [
//                               Text(
//                                 LocaleKeys.auth_hello.tr(),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineLarge
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ).tr(),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             children: [
//                               CustomTextFormField(
//                                 controller: emailController,
//                                 prefixIcon: const Icon(Icons.email_outlined),
//                                 labelText: LocaleKeys.auth_email.tr(),
//                                 hintText:
//                                     LocaleKeys.auth_email_placeholder.tr(),
//                                 keyboardType: TextInputType.emailAddress,
//                                 textInputAction: TextInputAction.next,
//                                 validator: emailValidator,
//                               ),
//                               CustomTextFormField(
//                                 controller: passwordController,
//                                 prefixIcon: const Icon(Icons.email_outlined),
//                                 labelText: LocaleKeys.auth_password.tr(),
//                                 hintText:
//                                     LocaleKeys.auth_password_placeholder.tr(),
//                                 keyboardType: TextInputType.emailAddress,
//                                 textInputAction: TextInputAction.next,
//                                 obscureText: true,
//                                 // validator: passwordValidator, //! The api does not require password validation but this could be useful in the future
//                               ),
//                             ],
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               LocaleKeys.auth_forgot_password.tr(),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               CustomElevatedButton(
//                                 onPressed: loginOnPress,
//                                 child: Text(
//                                   LocaleKeys.auth_login.tr(),
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .labelLarge
//                                       ?.copyWith(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(LocaleKeys
//                                           .auth_do_not_have_an_account)
//                                       .tr(),
//                                   TextButton(
//                                     onPressed: () async {

//                                     },
//                                     child: Text(
//                                       LocaleKeys.auth_register.tr(),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 TransparentScreen<LoginViewModel, LoginState>(
//                   child: const Center(
//                     child: CircularProgressIndicator.adaptive(),
//                   ),
//                   selector: (state) => state.isLoading,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void loginOnPress() async {
//     if (!mounted || !isFormValid(loginFormKey)) return;

//     final user = LoginRequest(
//       email: emailController.text,
//       password: passwordController.text,
//     );

//     final res = await loginViewModel.login(loginRequest: user);

//     // 🔥 Debug log ekleyelim
//     Logger().i("Login Response -> $res");
//     Logger().i("Error -> ${res.error}");
//     Logger().i("Response Message -> ${res.data?.response?.message}");

//     if (res.isSuccess) {
//       await loginViewModel.setRememberMeToSP(rememberMe: true);
//       await loginViewModel.setTokenToSP(token: res.data?.data?.token ?? '');

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeView(),
//         ),
//       );
//     } else {
//       CustomSnackbar.show(
//         context: context,
//         message: res.data?.response?.message ??
//             res.error ??
//             LocaleKeys.error_unknown_error.tr(),
//         responseType: ResponseType.error,
//       );
//     }
//   }
// }
// //   void loginOnPress() async {
// //     if (!mounted || !isFormValid(loginFormKey)) return;

// //     final user = LoginRequest(
// //       email: emailController.text,
// //       password: passwordController.text,
// //     );

// //     final res = await loginViewModel.login(loginRequest: user);

// //     if (res.isSuccess) {
// //       await loginViewModel.setRememberMeToSP(
// //         rememberMe: true,
// //       );

// //       await loginViewModel.setTokenToSP(
// //         token: res.data?.data?.token ?? '',
// //       );

// //       // await context.router.pushAndPopUntil(
// //       //   const DashboardWrapperRoute(),
// //       //   predicate: (route) => false,
// //       // );
// //     } else {
// //       CustomSnackbar.show(
// //         context: context,
// //         message:
// //             res.data?.response?.message ?? LocaleKeys.error_unknown_error.tr(),
// //         responseType: ResponseType.error,
// //       );
// //     }
// //   }
// // }

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:logger/logger.dart';
import 'package:smartmetric_case/feature/view/mixin/auth/auth_common_view_mixin.dart';
import 'package:smartmetric_case/feature/view/mixin/auth/login_view_mixin.dart';
import 'package:smartmetric_case/feature/view/mixin/common_view_mixin.dart';
import 'package:smartmetric_case/feature/view/transparent_view.dart';
import 'package:smartmetric_case/feature/view/widget/custom_snackbar.dart';
import 'package:smartmetric_case/feature/viewmodel/login_view_model.dart';
import 'package:smartmetric_case/product/navigation/app_router.dart'; // 🔥 Route için import
import 'package:smartmetric_case/product/state/login_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/response_type.dart';

import '../../../product/init/language/locale_keys.g.dart';

/// [LoginView] is a class that contains the login view.
@RoutePage()
final class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

final class _LoginViewState extends State<LoginView>
    with AuthCommonViewMixin, LoginViewMixin, DeviceSizeMixin, CommonViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginViewModel,
      child: GestureDetector(
        onTap: () => gestureOnTap(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding:
                      PaddingManager.normalPaddingSymmetricHorizontal(context),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(flex: 1),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                LocaleKeys.auth_hello.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ).tr(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: emailController,
                                prefixIcon: const Icon(Icons.email_outlined),
                                labelText: LocaleKeys.auth_email.tr(),
                                hintText:
                                    LocaleKeys.auth_email_placeholder.tr(),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: emailValidator,
                              ),
                              CustomTextFormField(
                                controller: passwordController,
                                prefixIcon: const Icon(Icons.email_outlined),
                                labelText: LocaleKeys.auth_password.tr(),
                                hintText:
                                    LocaleKeys.auth_password_placeholder.tr(),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              LocaleKeys.auth_forgot_password.tr(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomElevatedButton(
                                onPressed: loginOnPress,
                                child: Text(
                                  LocaleKeys.auth_login.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(LocaleKeys
                                          .auth_do_not_have_an_account)
                                      .tr(),
                                  TextButton(
                                    onPressed: () async {
                                      // 🔥 Login → SignUp yönlendirmesi
                                      await context.router
                                          .push(const SignUpRoute());
                                    },
                                    child: Text(
                                      LocaleKeys.auth_register.tr(),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TransparentScreen<LoginViewModel, LoginState>(
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  selector: (state) => state.isLoading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginOnPress() async {
    if (!mounted || !isFormValid(loginFormKey)) return;

    final user = LoginRequest(
      email: emailController.text,
      password: passwordController.text,
    );

    final res = await loginViewModel.login(loginRequest: user);

    Logger().i("Login Response -> $res");
    Logger().i("Error -> ${res.error}");
    Logger().i("Response Message -> ${res.data?.response?.message}");

    if (res.isSuccess) {
      await loginViewModel.setRememberMeToSP(rememberMe: true);
      await loginViewModel.setTokenToSP(token: res.data?.data?.token ?? '');

      // 🔥 Login başarılı → Home yönlendirmesi
      await context.router.pushAndPopUntil(
        const HomeRoute(),
        predicate: (_) => false,
      );
    } else {
      CustomSnackbar.show(
        context: context,
        message: res.data?.response?.message ??
            res.error ??
            LocaleKeys.error_unknown_error.tr(),
        responseType: ResponseType.error,
      );
    }
  }
}
