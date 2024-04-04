class ApiServieUrl {
  String domainName = 'http://10.0.2.2:3000';

  static String mobileNumberExist =
      '${ApiServieUrl().domainName}/users/isExistingUser';
  static String userLogin = '${ApiServieUrl().domainName}/auth/login';
  static String verifyOTP = '${ApiServieUrl().domainName}/auth/verify-otp';
  static String sendOTP = '${ApiServieUrl().domainName}/auth/sendOtp';
}
