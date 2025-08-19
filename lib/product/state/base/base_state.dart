import 'package:equatable/equatable.dart';

/// [BaseState] is the base state of all states
abstract class BaseState extends Equatable {
  /// Constructor
  const BaseState({this.isLoading = false});

  /// [isLoading] is the loading state of the state.
  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];

  /// copyWith method for BaseState class
  BaseState copyWith({bool? isLoading});
}
