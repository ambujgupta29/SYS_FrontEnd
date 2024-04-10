import 'package:dio/dio.dart';
import 'package:sys_mobile/network/dio_helper.dart';
import 'package:sys_mobile/url/api_service_urls.dart';

class LoginRepository {
  factory LoginRepository() {
    return _this;
  }

  LoginRepository._();

  static final LoginRepository _this = LoginRepository._();

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  static LoginRepository get instance => _this;

  Future<Response> isExistingUser(Map<String, dynamic> body) async {
    var response = await apiBaseHelper.post(
        url: ApiServiceUrl.mobileNumberExist, body: body);
    return response;
  }

  Future<Response> userLogin(Map<String, dynamic> body) async {
    var response =
        await apiBaseHelper.post(url: ApiServiceUrl.userLogin, body: body);
    return response;
  }

  Future<Response> verifyOTP(Map<String, dynamic> body) async {
    var response =
        await apiBaseHelper.post(url: ApiServiceUrl.verifyOTP, body: body);
    return response;
  }

  Future<Response> sendOTP(Map<String, dynamic> body) async {
    var response =
        await apiBaseHelper.post(url: ApiServiceUrl.sendOTP, body: body);
    return response;
  }

  Future<Response> userSignup(Map<String, dynamic> body) async {
    var response =
        await apiBaseHelper.post(url: ApiServiceUrl.userSignup, body: body);
    return response;
  }
}
