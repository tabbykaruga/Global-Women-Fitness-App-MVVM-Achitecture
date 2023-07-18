//convert response into a non-nullable object (model)

import 'package:learning_mvvm_architecture/app/extension.dart';
import 'package:learning_mvvm_architecture/data/responses/responses.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
        this?.id?.orEmpty() ?? EMPTY,
        this?.email?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain() {
    return Authentication(this?.user?.toDomain());
  }
}