import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/data/network/failure.dart';
import 'package:learning_mvvm_architecture/domain/repository/repository.dart';
import 'package:learning_mvvm_architecture/domain/usecase/baseUsecase.dart';

class ForgotPasswordUseCase implements BaseUseCase <String ,String>{
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async{
    return await _repository.forgottenPassword(input);
  }
}
