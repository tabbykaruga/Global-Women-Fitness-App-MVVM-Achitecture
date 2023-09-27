import 'package:dio/dio.dart';
import 'package:learning_mvvm_architecture/data/network/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  BAD_CERTIFICATE,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  UNKNOWN,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}
class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error){
    if(error is DioError){ //is error from  response of the API
      failure = _handleError(error);
    }else{
      failure = DataSource.DEFAULT.getFailure();
    }
  }
  Failure _handleError(DioError error){
    switch(error.type){
      case DioErrorType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();
      case DioErrorType.badCertificate:
        return DataSource.BAD_CERTIFICATE.getFailure();
      case DioErrorType.badResponse:
        switch(error.response?.statusCode){
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.connectionError:
      return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.unknown:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.BAD_CERTIFICATE:
        return Failure(ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.UNKNOWN:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.UNKNOWN);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.UNKNOWN);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int BAD_CERTIFICATE = 42;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORIZED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

  //local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECIEVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  static const String SUCCESS = "SUCCESS";
  static const String NO_CONTENT = "SUCCESS WITHOUT NO CONTENT";
  static const String BAD_REQUEST = "BAD REQUEST";
  static const String BAD_CERTIFICATE = "AUTHENTICATION WITH A CERTIFICATE FAILED";
  static const String FORBIDDEN = "FORBIDDEN";
  static const String UNAUTHORIZED = "UNAUTHORIZED";
  static const String NOT_FOUND = "NOT FOUND";
  static const String INTERNAL_SERVER_ERROR = "INTERNAL SERVER ERROR";

  //local status code
  static const String UNKNOWN = "SOMETHING WENT WRONG TRY AGAIN LATER";
  static const String CONNECT_TIMEOUT = "CONNECT TIMEOUT ERROR TRY AGAIN LATER";
  static const String CANCEL = "REQUEST CNACLED TRY AGAIN LATER";
  static const String RECIEVE_TIMEOUT = "TIME OUT ERROR TRY AGAIN LATER";
  static const String SEND_TIMEOUT = "TIME OUT ERROR TRY AGAIN LATER";
  static const String CACHE_ERROR = "CACHE ERROR TRY AGAIN LATER";
  static const String NO_INTERNET_CONNECTION = "NO INTERNET CONNECTION";
}
class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;

}
