import 'package:sys_mobile/common/screen_state.dart';
import 'package:sys_mobile/models/login/verify_otp_model.dart';

abstract class LoginState extends ScreenState {}

class LoginInitial extends LoginState {}

class LoginFailedState extends LoginState {}

//Does Mobile number exist State

class MobileNumberExistProgressState extends LoginState {}

class MobileNumberExistFailedState extends LoginState {
  String message;
  MobileNumberExistFailedState(this.message);
}

class MobileNumberExistSuccessState extends LoginState {
  bool message;
  MobileNumberExistSuccessState(this.message);
}

// User Login

class UserLoginProgressState extends LoginState {}

class UserLoginFailedState extends LoginState {
  String message;
  UserLoginFailedState(this.message);
}

class UserLoginSuccessState extends LoginState {
  String message;
  UserLoginSuccessState(this.message);
}

// VERIFY OTP

class VerifyOTPProgressState extends LoginState {}

class VerifyOTPFailedState extends LoginState {
  String message;
  VerifyOTPFailedState(this.message);
}

class VerifyOTPSuccessState extends LoginState {
  VerifyOTPModel verifyOTPModel;
  VerifyOTPSuccessState(this.verifyOTPModel);
}

// SEND OTP

class SendOTPProgressState extends LoginState {}

class SendOTPFailedState extends LoginState {
  String message;
  SendOTPFailedState(this.message);
}

class SendOTPSuccessState extends LoginState {
  String message;
  SendOTPSuccessState(this.message);
}

// user signup


class UserSignupProgressState extends LoginState {}

class UserSignupFailedState extends LoginState {
  String message;
  UserSignupFailedState(this.message);
}

class UserSignupSuccessState extends LoginState {
  String message;
  UserSignupSuccessState(this.message);
}


