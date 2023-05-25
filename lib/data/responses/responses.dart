import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

//to generate the response.g.dart
//flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class BaseResponse {
  // ? = used to signify null
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  late String? message;
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  late String? id;
  @JsonKey(name: "email")
  late String? email;
  @JsonKey(name: "first_name")
  late String? name;

  UserResponse(this.id, this.email, this.name);

  //from json
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  //to json
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "user")
  UserResponse? user;

  AuthenticationResponse(this.user);

  //from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  //to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
