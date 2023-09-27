import 'package:learning_mvvm_architecture/data/request/request.dart';
import 'package:learning_mvvm_architecture/data/responses/responses.dart';
import '../network/app_api.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ForgottenPasswordResponse> forgottenPassword(String email);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceUser _appServiceUser;

  RemoteDataSourceImplementer(this._appServiceUser);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceUser.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgottenPasswordResponse> forgottenPassword(String email) async {
    return await _appServiceUser.forgottenPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceUser.register(
        registerRequest.countryCode,
        registerRequest.userName,
        registerRequest.email,
        registerRequest.phoneNo,
        registerRequest.password,
        registerRequest.profilePicture);
  }

  @override
  Future<HomeResponse> getHome() async{
    return await _appServiceUser.getHome();
  }
}
