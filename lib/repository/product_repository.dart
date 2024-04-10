import 'package:dio/dio.dart';
import 'package:sys_mobile/network/dio_helper.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';
import 'package:sys_mobile/url/api_service_urls.dart';

class ProductRepository {
  factory ProductRepository() {
    return _this;
  }

  ProductRepository._();

  static final ProductRepository _this = ProductRepository._();

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  static ProductRepository get instance => _this;

  Future<Response> fetchAllProducts() async {
    final token = await AppStorage().getString(USER_TOKEN);
    var response = await apiBaseHelper.get(
        url: ApiServiceUrl.fetchAllProducts,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    return response;
  }

  Future<Response> fetchImage(Map<String,dynamic> body) async {
    final token = await AppStorage().getString(USER_TOKEN);
    var response = await apiBaseHelper.post(
        url: ApiServiceUrl.fetchImage,
        body: body,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    return response;
  }
  Future<Response> fetchMultipleImages(Map<String,dynamic> body) async {
    final token = await AppStorage().getString(USER_TOKEN);
    var response = await apiBaseHelper.post(
        url: ApiServiceUrl.fetchMultipleImages,
        body: body,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    return response;
  }

 
}
