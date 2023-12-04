import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'baseUsecase.dart';

class ExerciseDetailsUseCase extends BaseUseCase<void, ExerciseDetails> {
  Repository repository;

  ExerciseDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ExerciseDetails>> execute(void input) {
    return repository.getExerciseDetails();
  }
}