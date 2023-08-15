import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezedDataClasses.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String countryCode, String userName, String email,
      String phoneNo, String password, String profilePicture) = _RegisterObject;
}
