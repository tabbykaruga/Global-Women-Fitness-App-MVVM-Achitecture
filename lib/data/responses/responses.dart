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

@JsonSerializable()
class ForgottenPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;

  ForgottenPasswordResponse(this.support);

  Map<String, dynamic> toJson() => _$ForgottenPasswordResponseToJson(this);

  factory ForgottenPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgottenPasswordResponseFromJson(json);

}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  ServiceResponse(this.id,this.title,this.image);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
}

@JsonSerializable()
class ExerciseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  ExerciseResponse(this.id,this.title,this.image);

  Map<String, dynamic> toJson() => _$ExerciseResponseToJson(this);

  factory ExerciseResponse.fromJson(Map<String,dynamic> json)=>
      _$ExerciseResponseFromJson(json);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;

  BannerResponse(this.id,this.title,this.image,this.link);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse{
  //services response
  @JsonKey(name: "services")
  List<ServiceResponse>? services;

  //services exercise
  @JsonKey(name: "exercises")
  List<ExerciseResponse>? exercises;

  //services banners
  @JsonKey(name: "banners")
  List<BannerResponse>? banners;

  HomeDataResponse(this.services,this.exercises,this.banners);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

//this class contains status and message hence extends base response
@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse(this.data);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

}
