import 'dart:ffi';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/presentation/base/baseViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRender.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRender.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecase/ExerciseDetailsUseCase.dart';
import '../common/stateRenderImpl.dart';

class ExerciseDetailsViewModel extends BaseViewModel
    with ExerciseDetailsViewModelInput, ExerciseDetailsViewModelOutput {
  final _exerciseDetailsStreamController = BehaviorSubject<ExerciseDetails>();

  final ExerciseDetailsUseCase exerciseDetailsUseCase;

  ExerciseDetailsViewModel(this.exerciseDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.fullscreenLoadingState));
    (await exerciseDetailsUseCase.execute(Void)).fold(
          (failure) {
            inputState.add(ErrorState(stateRenderType: StateRenderType.fullscreenErrorState,message: failure.message));
      },
          (exerciseDetails) async {
        inputState.add(ContentState());
        inputExerciseDetails.add(exerciseDetails);
      },
    );
  }

  @override
  void dispose() {
    _exerciseDetailsStreamController.close();
  }

  @override
  Sink get inputExerciseDetails => _exerciseDetailsStreamController.sink;

  //output
  @override
  Stream<ExerciseDetails> get outputExerciseDetails =>
      _exerciseDetailsStreamController.stream.map((exercises) => exercises);
}

abstract class ExerciseDetailsViewModelInput {
  Sink get inputExerciseDetails;
}

abstract class ExerciseDetailsViewModelOutput {
  Stream<ExerciseDetails> get outputExerciseDetails;
}