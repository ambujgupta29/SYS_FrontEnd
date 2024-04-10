class ApiServiceUrl {
  String domainName = 'http://10.0.2.2:3000';

  static String mobileNumberExist =
      '${ApiServiceUrl().domainName}/users/isExistingUser';
  static String userLogin = '${ApiServiceUrl().domainName}/sms/sendOtp';
  static String userSignup = '${ApiServiceUrl().domainName}/users/';
  static String verifyOTP = '${ApiServiceUrl().domainName}/auth/verify-otp';
  static String sendOTP = '${ApiServiceUrl().domainName}/sms/sendOtp';
  static String fetchAllProducts = '${ApiServiceUrl().domainName}/product';
  static String fetchImage = '${ApiServiceUrl().domainName}/upload/getFile';
  static String fetchMultipleImages = '${ApiServiceUrl().domainName}/upload/getMultipleFiles';
}
