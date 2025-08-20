import 'package:smartmetric_case/product/state/base/base_state.dart';

/// [SignUpState] is the state of the sign up.
final class SignUpState extends BaseState {
  /// Constructor
  const SignUpState({
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
  SignUpState copyWith({bool? isLoading, bool? isVisible}) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
