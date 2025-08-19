import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

/// This is a model class for login requests.
/// It contains the email and password fields.
/// It is used to send login requests to the server.
@JsonSerializable()
@immutable
final class LoginRequest extends BaseModel<LoginRequest> with EquatableMixin {
  /// Constructor
  LoginRequest({this.email, this.password});

  /// [email] is the email of the user.
  final String? email;

  /// [password] is the password of the user.
  final String? password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [email, password];

  /// copyWith method for LoginRequest class
  LoginRequest copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
