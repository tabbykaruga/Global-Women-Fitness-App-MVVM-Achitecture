import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/data/network/failure.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/domain/usecase/baseUsecase.dart';

import '../repository/repository.dart';

class HomeUseCase extends BaseUseCase<void,HomeObject>{
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
   return await _repository.getHome();
  }

}