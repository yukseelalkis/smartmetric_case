import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'response.dart';
import 'login_data.dart';
import 'package:gen/gen.dart';
part 'login_response.g.dart';

@JsonSerializable()
@immutable
final class LoginResponse extends BaseModel<LoginResponse> with EquatableMixin {
  final Response? response;
  final LoginData? data;

  LoginResponse({
    this.response,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props => [response, data];

  LoginResponse copyWith({
    Response? response,
    LoginData? data,
  }) {
    return LoginResponse(
      response: response ?? this.response,
      data: data ?? this.data,
    );
  }
}
