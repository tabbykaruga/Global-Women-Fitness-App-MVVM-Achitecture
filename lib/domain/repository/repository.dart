import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import '../../data/network/failure.dart';
import '../../data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgottenPassword(String email);
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
  Future<Either<Failure, ExerciseDetails>> getExerciseDetails();
}

