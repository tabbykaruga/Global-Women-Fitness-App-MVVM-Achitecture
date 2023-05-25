import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../app/constants.dart';
import '../responses/responses.dart';
part 'app_api.g.dart';


@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceUser {
  factory AppServiceUser(Dio dio,{String baseUrl}) =_AppServiceUser;
  
  @POST("login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      );
}
