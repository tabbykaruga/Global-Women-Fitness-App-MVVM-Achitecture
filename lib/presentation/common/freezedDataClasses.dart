import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezedDataClasses.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}
