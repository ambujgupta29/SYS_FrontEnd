class FetchUserInfoModel {
  String? sId;
  String? userName;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? profilePicture;
  List<String>? favourites;
  List<String>? cart;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FetchUserInfoModel(
      {this.sId,
      this.userName,
      this.fullName,
      this.mobileNumber,
      this.email,
      this.profilePicture,
      this.favourites,
      this.cart,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FetchUserInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    fullName = json['fullName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    favourites = json['favourites'].cast<String>();
    cart = json['cart'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    data['favourites'] = this.favourites;
    data['cart'] = this.cart;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
