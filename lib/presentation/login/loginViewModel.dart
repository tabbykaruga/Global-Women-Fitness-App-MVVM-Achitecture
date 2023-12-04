import 'dart:async';
import 'package:learning_mvvm_architecture/domain/usecase/LoginUseCase.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRender.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import '../base/baseViewModel.dart';
import '../common/freezedDataClasses.dart';
import 'dart:developer';


class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    //view tells state renderer ,to show content on the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));

    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // inputState.add(ErrorState(
                  //     stateRenderType: StateRenderType.popupErrorState,
                  //     message: failure.message))

            inputState.add(ContentState()),
        //navigate to main screen after login
        isUserLoggedInSuccessfullyStreamController.add(true)
                },
            (data) {
                  inputState.add(ContentState());
                  //navigate to main screen after login
                  isUserLoggedInSuccessfullyStreamController.add(true);
              }
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);

    //update the input everytime user changes
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  //private functions
  bool isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return isPasswordValid(loginObject.password) &&
        isUserNameValid(loginObject.userName);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class LoginViewModelInputs {
  //three functions
  setUserName(String userName);
  setPassword(String password);
  login();

  //two sinks for the streams
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
