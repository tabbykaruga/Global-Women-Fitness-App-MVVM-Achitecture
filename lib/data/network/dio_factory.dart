import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learning_mvvm_architecture/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String app_json = "application/json";
const String content_type = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String default_lang = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      content_type: app_json,
      accept: app_json,
      authorization: Constants.token,
      default_lang: "en",
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        headers: headers);

    if (kReleaseMode) {
      print("release mode no legs");
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true, requestBody: true, responseHeader: true),
      );
    }
    return dio;
  }
}
