import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'login_data.g.dart';

@JsonSerializable()
@immutable
final class LoginData extends BaseModel<LoginData> with EquatableMixin {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? token;

  LoginData({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

  @override
  List<Object?> get props => [id, name, email, photoUrl, token];

  LoginData copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return LoginData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }
}
