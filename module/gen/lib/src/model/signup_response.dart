import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'signup_response.g.dart';

@JsonSerializable()
final class SignupResponse extends BaseModel<SignupResponse> with EquatableMixin {
  final Response? response;
  final LoginData? data;

  SignupResponse({
    this.response,
    this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);

  @override
  List<Object?> get props => [response, data];

  SignupResponse copyWith({
    Response? response,
    LoginData? data,
  }) {
    return SignupResponse(
      response: response ?? this.response,
      data: data ?? this.data,
    );
  }
}
