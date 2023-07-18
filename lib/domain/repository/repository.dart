import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import '../../data/network/failure.dart';
import '../../data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
