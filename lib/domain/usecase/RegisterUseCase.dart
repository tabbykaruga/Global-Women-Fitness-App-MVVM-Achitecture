import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/data/network/failure.dart';
import 'package:learning_mvvm_architecture/data/request/request.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/domain/repository/repository.dart';
import 'package:learning_mvvm_architecture/domain/usecase/baseUsecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.countryCode,
        input.userName,
        input.email,
        input.phoneNo,
        input.password,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String countryCode;
  String userName;
  String email;
  String phoneNo;
  String password;
  String profilePicture;

  RegisterUseCaseInput(this.countryCode, this.userName, this.phoneNo,
      this.email, this.password, this.profilePicture);
}
