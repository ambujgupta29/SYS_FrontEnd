
import 'package:sys_mobile/constants/app_constants.dart';

class ScreenState {
  String? errorCode;
  String? _errorMsg;

  bool isInvalidException = false;

  set errorMsg(String message) {
    _errorMsg = message;
  }

  String get errorMsg {
    if (errorCode != null && errorCode == AppConstants.ERROR_UNABLE_TO_RESOLVE_SERVICE) {
      return AppConstants.NO_NETWORK_ERROR;
    }
    return _errorMsg!;
  }
}
