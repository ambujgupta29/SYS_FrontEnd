abstract class LoginEvent {}

//Does Mobile number exist Event

class MobileNumberExistEvent extends LoginEvent {
  String mobileNumber;
  MobileNumberExistEvent({required this.mobileNumber});
}

// User Login Event

class UserLoginEvent extends LoginEvent {
  String mobileNumber;
  UserLoginEvent({required this.mobileNumber});
}

// VERIFY OTP

class VerifyOTPEvent extends LoginEvent {
  String mobileNumber;
  String otp;
  VerifyOTPEvent({required this.mobileNumber, required this.otp});
}

//

class SendOTPEvent extends LoginEvent {
  String mobileNumber;
  SendOTPEvent({required this.mobileNumber});
}
