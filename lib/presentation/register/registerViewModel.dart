import 'dart:async';
import 'dart:html';
import 'package:learning_mvvm_architecture/domain/usecase/RegisterUseCase.dart';
import 'package:learning_mvvm_architecture/presentation/base/baseViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/common/freezedDataClasses.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';

import '../common/stateRender.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneNoStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePicStreamController =
      StreamController<File>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  //at the freezeDataClass
  var registerViewObject = RegisterObject("", "", "", "", "", "");

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _phoneNoStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePicStreamController.close();
    _isAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  register() async {
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    (await _registerUseCase?.execute(RegisterUseCaseInput(
            registerViewObject.userName,
            registerViewObject.email,
            registerViewObject.password,
            registerViewObject.phoneNo,
            registerViewObject.countryCode,
            registerViewObject.profilePicture)))
        ?.fold(
            (failure) => {
                  inputState.add(ErrorState(
                      stateRenderType: StateRenderType.fullscreenErrorState,
                      message: failure.message))
                }, (data) {
      inputState.add(ContentState());
      //navigate to main screen
      // isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      //update register view object with username value
      registerViewObject = registerViewObject.copyWith(userName: userName);
    } else {
      //reset the value in the register view object
      registerViewObject = registerViewObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    if (_isEmailValid(email)) {
      //update register view object with email value
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      //reset the value in the register view object
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      //update register view object with password value
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      //reset the value in the register view object
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setPhoneNo(String phoneNo) {
    if (_isPasswordValid(phoneNo)) {
      //update register view object with phoneNo value
      registerViewObject = registerViewObject.copyWith(phoneNo: phoneNo);
    } else {
      //reset the value in the register view object
      registerViewObject = registerViewObject.copyWith(phoneNo: "");
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      //update register view object with countryCode value
      registerViewObject =
          registerViewObject.copyWith(countryCode: countryCode);
    } else {
      //reset the value in the register view object
      registerViewObject = registerViewObject.copyWith(countryCode: "");
    }
    _validate();
  }

  @override
  setProfilePic(File file) {
    if (file.relativePath!.isNotEmpty) {
      //update register view object with countryCode value
      registerViewObject =
          registerViewObject.copyWith(profilePicture: file.name);
    } else {
      //reset the value in the register view object
      registerViewObject = registerViewObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  //--inputs
  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputPhoneNo => _phoneNoStreamController.sink;

  @override
  Sink get inputProfilePic => _profilePicStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  //--outputs
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppString.invalidEmail);

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppString.invalidPassword);

  @override
  Stream<String?> get outputErrorPhoneNo => outputIsPhoneNoValid.map(
      (isPhoneNoValid) => isPhoneNoValid ? null : AppString.invalidPhoneNo);

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppString.invalidUserName);

  //-- output validations
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsPhoneNoValid => _phoneNoStreamController.stream
      .map((phoneNo) => _isPhoneNoValid(phoneNo));

  @override
  Stream<File> get outputIsProfilePicValid =>
      _profilePicStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
        .hasMatch(email);
  }

  bool _isPhoneNoValid(String phoneNo) {
    return phoneNo.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return RegExp(r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+$).{12,}$")
        .hasMatch(password);
  }

  bool _validateAllInputs() {
    return registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.userName.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.phoneNo.isNotEmpty &&
        registerViewObject.countryCode.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  register();
  setUserName(String userName);
  setEmail(String email);
  setPhoneNo(String phoneNo);
  setCountryCode(String countryCode);
  setPassword(String password);
  setProfilePic(File file);

  Sink get inputUserName;
  Sink get inputPhoneNo;
  Sink get inputPassword;
  Sink get inputEmail;
  Sink get inputProfilePic;
  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsPhoneNoValid;
  Stream<String?> get outputErrorPhoneNo;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<File> get outputIsProfilePicValid;
  Stream<bool> get outputIsAllInputsValid;
}
