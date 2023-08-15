import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../app/constants.dart';
import '../responses/responses.dart';
part 'app_api.g.dart';


@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceUser {
  factory AppServiceUser(Dio dio,{String baseUrl}) =_AppServiceUser;
  
  @POST("user/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      );

  @POST("user/forgotPassword")
  Future<ForgottenPasswordResponse> forgottenPassword(@Field("email") String email);

  @POST("user/register")
  Future<AuthenticationResponse> register(
      @Field("country_code") String countryCode,
      @Field("user_name") String userName,
      @Field("email") String email,
      @Field("phone_no") String phoneNo,
      @Field("password") String password,
      @Field("profile_pic") String profilePicture,
      );
}

