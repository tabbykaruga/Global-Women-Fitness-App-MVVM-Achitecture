import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/data/network/failure.dart';
import 'package:learning_mvvm_architecture/data/request/request.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/domain/repository/repository.dart';
import 'package:learning_mvvm_architecture/domain/usecase/baseUsecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email,input.password));
  }

}
class LoginUseCaseInput{
  String email;
  String password;

  LoginUseCaseInput(this.email,this.password);
}