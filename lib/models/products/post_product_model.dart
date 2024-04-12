class PostProductModel {
  String? productName;
  String? productCategory;
  int? productPrice;
  List<String>? images;
  String? user;
  String? productDesc;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PostProductModel(
      {this.productName,
      this.productCategory,
      this.productPrice,
      this.images,
      this.user,
      this.productDesc,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PostProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productCategory = json['productCategory'];
    productPrice = json['productPrice'];
    images = json['images'].cast<String>();
    user = json['user'];
    productDesc = json['productDesc'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productCategory'] = this.productCategory;
    data['productPrice'] = this.productPrice;
    data['images'] = this.images;
    data['user'] = this.user;
    data['productDesc'] = this.productDesc;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}