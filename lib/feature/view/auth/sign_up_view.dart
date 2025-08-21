import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:smartmetric_case/feature/view/mixin/auth/auth_common_view_mixin.dart';
import 'package:smartmetric_case/feature/view/mixin/auth/sign_up_view_mixin.dart';
import 'package:smartmetric_case/feature/view/mixin/common_view_mixin.dart';
import 'package:smartmetric_case/feature/view/transparent_view.dart';
import 'package:smartmetric_case/feature/view/widget/custom_snackbar.dart';
import 'package:smartmetric_case/feature/viewmodel/signup_view_model.dart';
import 'package:smartmetric_case/product/init/language/locale_keys.g.dart';
import 'package:smartmetric_case/product/navigation/app_router.dart';
import 'package:smartmetric_case/product/state/sign_up_state.dart';
import 'package:smartmetric_case/product/utility/constant/enums/response_type.dart';

/// [SignUpView] is a class that contains the signup view.
@RoutePage()
final class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

final class _SignUpViewState extends State<SignUpView>
    with
        AuthCommonViewMixin,
        DeviceSizeMixin,
        CommonViewMixin,
        SignUpViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => signupViewModel,
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
                    key: signupFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(flex: 1),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                LocaleKeys.auth_hello,
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
                          flex: 3,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: fullnameController,
                                prefixIcon: const Icon(Icons.person),
                                labelText: LocaleKeys.auth_fullname.tr(),
                                hintText:
                                    LocaleKeys.auth_fullname_placeholder.tr(),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: fullnameValidator,
                              ),
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
                                prefixIcon: const Icon(Icons.password),
                                labelText: LocaleKeys.auth_password.tr(),
                                hintText:
                                    LocaleKeys.auth_password_placeholder.tr(),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                              ),
                              CustomTextFormField(
                                controller: confirmPasswordController,
                                prefixIcon: const Icon(Icons.lock_outline),
                                labelText:
                                    LocaleKeys.auth_confirm_password.tr(),
                                hintText: LocaleKeys
                                    .auth_confirm_password_placeholder
                                    .tr(),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomElevatedButton(
                                onPressed: _signUpOnPress,
                                child: Text(
                                  LocaleKeys.auth_register.tr(),
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
                                          .auth_i_have_already_have_an_account)
                                      .tr(),
                                  TextButton(
                                    onPressed: () async {
                                      // Signup -> Login yönlendirmesi
                                      await context.router.replace(
                                        const LoginRoute(),
                                      );
                                    },
                                    child: Text(
                                      LocaleKeys.auth_login.tr(),
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
                TransparentScreen<SignUpViewModel, SignUpState>(
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

  Future<void> _signUpOnPress() async {
    if (!mounted || !isFormValid(signupFormKey)) return;

    final req = SignupRequest(
      email: emailController.text,
      name: fullnameController.text,
      password: passwordController.text,
    );

    final res = await signupViewModel.signup(signupRequest: req);

    if (res.isSuccess) {
      // Signup başarılı -> Home aç
      await context.router.pushAndPopUntil(
        const HomeRoute(),
        predicate: (_) => false,
      );
    } else {
      CustomSnackbar.show(
        context: context,
        message: res.error ?? LocaleKeys.error_unknown_error.tr(),
        responseType: ResponseType.error,
      );
    }
  }
}
