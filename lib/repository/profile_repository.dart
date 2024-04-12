import 'package:dio/dio.dart';
import 'package:sys_mobile/network/dio_helper.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';
import 'package:sys_mobile/url/api_service_urls.dart';

class ProfileRepository {
  factory ProfileRepository() {
    return _this;
  }

  ProfileRepository._();

  static final ProfileRepository _this = ProfileRepository._();

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  static ProfileRepository get instance => _this;

  Future<Response> getProfilePic() async {
    final token = await AppStorage().getString(USER_TOKEN);
    var response = await apiBaseHelper.get(
        url: ApiServiceUrl.getProfilePic,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    return response;
  }

  Future<Response> uploadProfilePic(FormData body) async {
    final token = await AppStorage().getString(USER_TOKEN);
    var response = await apiBaseHelper.patchFormData(
        body: body,
        url: ApiServiceUrl.uploadProfilePic,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    return response;
  }
}
