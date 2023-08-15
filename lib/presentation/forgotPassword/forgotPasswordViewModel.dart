import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:learning_mvvm_architecture/domain/usecase/ForgotPasswordUseCase.dart';
import 'package:learning_mvvm_architecture/presentation/base/baseViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRender.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgottenPasswordViewModelInputs, ForgottenPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<String>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  resetPassword() async {
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupErrorState));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.fullscreenErrorState,
          message: failure.message));
    }, (supportMessage) {
      inputState.add(SuccessState(supportMessage));
    });
  }

  @override
  Sink get inputIsAllInputValid =>
      _isAllInputValidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController.stream.map((isAllInputValid) => _isAllInputValid());

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => isEmailValid(email));

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }
  _isAllInputValid(){
    return isEmailValid(email);
  }

  bool isEmailValid(String email) {
    return email.isNotEmpty;
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email =email;
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgottenPasswordViewModelInputs {
  //two functions
  setEmail(String email);
  resetPassword();

  //one sinks for the streams
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

abstract class ForgottenPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}
