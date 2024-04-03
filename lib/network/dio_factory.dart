// import 'package:alice/alice.dart';

import 'package:dio/dio.dart';
import 'package:sys_mobile/network/dio_retry_interceptor.dart';
import 'package:sys_mobile/network/network_exceptions.dart';

class DioFactory {
  static final DioFactory _singleton = DioFactory._internal();
  Dio? dio;

  factory DioFactory() {
    return _singleton;
  }

  DioFactory._internal() {
    dio = Dio();

    void handleDioError(DioException e, ErrorInterceptorHandler handler) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      } else if (e.type == DioExceptionType.unknown) {
        throw NoInternetException('');
      }
      // Continue handling the error by calling the next error handler
      handler.next(e);
    }

    dio?.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        return handleDioError(e, handler);
      },
    ));

    dio!.interceptors.add(RetryInterceptor(
      dio: dio!,
      retries: 2,
      retryEvaluator: (error, attempt) {
        if (error.type == DioExceptionType.connectionError && attempt == 1) {
          return false;
        } else if (error.type == DioExceptionType.unknown && attempt == 1) {
          return false;
        }
        return true;
      },
    ));
    dio?.options.receiveDataWhenStatusError = true;
    dio?.options.connectTimeout =
        const Duration(milliseconds: 10000); //10*1000;
    dio?.options.receiveTimeout =
        const Duration(milliseconds: 10000); //10*1000;
  }

  Dio getDio() => dio!;
}
