import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sys_mobile/network/dio_factory.dart';
import 'package:sys_mobile/network/network_exceptions.dart';

class ApiBaseHelper {
  DioFactory dioFactory = DioFactory();

  Future<Response> get({String? url, Options? options}) async {
    try {
      final response = await dioFactory.getDio().get(url!, options: options);
      return _returnResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      }
      return _returnResponse(ex.response);
    }
  }

  Future<Response> getWithParams(
      {String? url, Map<String, dynamic>? params, Options? options}) async {
    try {
      final response = await dioFactory
          .getDio()
          .get(url!, queryParameters: params, options: options);
      return _returnResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      }
      return _returnResponse(ex.response);
    }
  }

  Future<Response> postWithParams(
      {String? url, Map<String, dynamic>? params, Options? options}) async {
    try {
      final response = await dioFactory
          .getDio()
          .post(url!, queryParameters: params, options: options);

      return _returnResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      }
      return _returnResponse(ex.response);
    }
  }

  Future<Response> post(
      {String? url, Map<String, dynamic>? body, Options? options}) async {
    try {
      final response = await dioFactory.getDio().post(
            url!,
            data: body,
            options: options,
          );

      return _returnResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      }
      return _returnResponse(ex.response);
    }
  }

  Future<Response> postformdata(
      {String? url, FormData? body, Options? options}) async {
    try {
      final response = await dioFactory.getDio().post(
            url!,
            data: body,
            options: options,
          );

      return _returnResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      }
      return _returnResponse(ex.response);
    }
  }

  Future<Response> postMultiPart(
      {String? url, required String key, File? file, Options? options}) async {
    String fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      key: await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      final response = await dioFactory
          .getDio()
          .post(url!, data: formData, options: options);

      return _returnResponse(response);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        throw NoInternetException('');
      }
      return _returnResponse(ex.response);
    }
  }
}

Response _returnResponse(Response? response) {
  if (response != null && response.statusCode != null) {
    var responseJson = response.data;
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        throw BadRequestException(responseJson["message"]);
      case 401:
        throw UnauthorisedException(responseJson["message"]);
      case 403:
        throw UnauthorisedException(responseJson["message"]);
      case 404:
        throw NotFoundException(responseJson["message"]);
      case 500:
        throw FetchDataException(
            'Something went wrong, Please try again later.');
      default:
        throw FetchDataException(
            'Something went wrong, Please try again later.');
    }
  } else {
    throw FetchDataException('Some error occurred please try again');
  }
}
