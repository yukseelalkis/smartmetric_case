import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'signup_request.g.dart';

@JsonSerializable()
@immutable
final class SignupRequest extends BaseModel<SignupRequest> with EquatableMixin {
  final String? email;
  final String? name;
  final String? password;

  SignupRequest({
    this.email,
    this.name,
    this.password,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  @override
  List<Object?> get props => [email, name, password];

  SignupRequest copyWith({
    String? email,
    String? name,
    String? password,
  }) {
    return SignupRequest(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
