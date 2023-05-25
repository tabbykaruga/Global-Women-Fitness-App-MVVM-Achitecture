import 'package:learning_mvvm_architecture/data/request/request.dart';
import 'package:learning_mvvm_architecture/data/responses/responses.dart';
import '../network/app_api.dart';

abstract class RemoteDataSource{
   Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource{
  final AppServiceUser _appServiceUser;

  RemoteDataSourceImplementer(this._appServiceUser);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceUser.login(loginRequest.email,loginRequest.password);
  }

}