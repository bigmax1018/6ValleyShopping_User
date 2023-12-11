import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    }

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        if (kDebugMode) {
          print(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
        }
      }
    } else {
      if (kDebugMode) {
        print(response.data);
      }
    }

    if (kDebugMode) {
      print("<-- END HTTP");
    }

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print("ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    }
    return super.onError(err, handler);
  }
}
