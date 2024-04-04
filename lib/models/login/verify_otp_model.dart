class VerifyOTPModel {
  String? message;
  String? accessToken;

  VerifyOTPModel({this.message, this.accessToken});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    return data;
  }
}