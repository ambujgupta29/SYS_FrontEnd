class ApiServiceUrl {
  String domainName = 'http://10.0.2.2:3000';

  static String mobileNumberExist =
      '${ApiServiceUrl().domainName}/users/isExistingUser';
  static String userLogin = '${ApiServiceUrl().domainName}/sms/sendOtp';
  static String userSignup = '${ApiServiceUrl().domainName}/users/';
  static String verifyOTP = '${ApiServiceUrl().domainName}/auth/verify-otp';
  static String sendOTP = '${ApiServiceUrl().domainName}/sms/sendOtp';
  static String fetchAllProducts =
      '${ApiServiceUrl().domainName}/product/search';
  static String fetchImage = '${ApiServiceUrl().domainName}/upload/getFile';
  static String fetchMultipleImages =
      '${ApiServiceUrl().domainName}/upload/getMultipleFiles';
  static String postProduct = '${ApiServiceUrl().domainName}/product';
  static String getuserPost = '${ApiServiceUrl().domainName}/product/User';
  static String getProfilePic =
      '${ApiServiceUrl().domainName}/users/profilepic';
  static String uploadProfilePic =
      '${ApiServiceUrl().domainName}/users/profilepic';
  static String fetchProductById =
      '${ApiServiceUrl().domainName}/product/productId';
  static String fetchUserInfo = '${ApiServiceUrl().domainName}/users/userinfo';

  static String addToFav = '${ApiServiceUrl().domainName}/users/addItemToFav';
  static String removeFromFav =
      '${ApiServiceUrl().domainName}/users/removeItemFromFav';

  static String addToCart = '${ApiServiceUrl().domainName}/users/addItemToCart';
  static String removeFromCart =
      '${ApiServiceUrl().domainName}/users/removeItemFromCart';
  static String getMaxPrice = '${ApiServiceUrl().domainName}/product/Maxprice';
}
