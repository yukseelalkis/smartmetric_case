import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'response.g.dart';

@JsonSerializable()
@immutable
final class Response extends BaseModel<Response> with EquatableMixin {
  final int? code;
  final String? message;

  Response({
    this.code,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseToJson(this);

  @override
  List<Object?> get props => [code, message];

  Response copyWith({
    int? code,
    String? message,
  }) {
    return Response(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
