import 'package:smartmetric_case/product/state/base/base_state.dart';

/// [LoginState] is the state of the login.
final class LoginState extends BaseState {
  /// Constructor
  const LoginState({
    this.isVisible = false,
    super.isLoading,
  });

  @override
  List<Object?> get props => super.props
    ..addAll([
      isLoading,
      isVisible,
    ]);

  /// [isVisible] is the visibility state of the password field.
  final bool isVisible;

  @override
  LoginState copyWith({bool? isLoading, bool? isVisible}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
