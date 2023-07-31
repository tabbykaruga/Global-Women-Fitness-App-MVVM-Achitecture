import 'package:learning_mvvm_architecture/data/network/errorHandler.dart';

class Failure{
  int code ;
  String message;

  Failure(this.code,this.message);
}
class DefaultFailure extends Failure{
  DefaultFailure():super(ResponseCode.DEFAULT,ResponseMessage.UNKNOWN);
}