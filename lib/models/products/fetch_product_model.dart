// class FetchProductModel {
//   List<ProductList>? productList;

//   FetchProductModel({this.productList});

//   FetchProductModel.fromJson(Map<String, dynamic> json) {
//     if (json['productList'] != null) {
//       productList = <ProductList>[];
//       json['productList'].forEach((v) {
//         productList!.add(new ProductList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.productList != null) {
//       data['productList'] = this.productList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ProductList {
//   String? sId;
//   String? productName;
//   String? productCategory;
//   String? productPrice;
//   List<String>? images;
//   User? user;
//   String? productDesc;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   ProductList(
//       {this.sId,
//       this.productName,
//       this.productCategory,
//       this.productPrice,
//       this.images,
//       this.user,
//       this.productDesc,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   ProductList.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     productName = json['productName'];
//     productCategory = json['productCategory'];
//     productPrice = json['productPrice'];
//     images = json['images'].cast<String>();
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     productDesc = json['productDesc'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['productName'] = this.productName;
//     data['productCategory'] = this.productCategory;
//     data['productPrice'] = this.productPrice;
//     data['images'] = this.images;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['productDesc'] = this.productDesc;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class User {
//   String? sId;
//   String? userName;
//   String? fullName;
//   String? mobileNumber;
//   String? email;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   User(
//       {this.sId,
//       this.userName,
//       this.fullName,
//       this.mobileNumber,
//       this.email,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userName = json['userName'];
//     fullName = json['fullName'];
//     mobileNumber = json['mobileNumber'];
//     email = json['email'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['userName'] = this.userName;
//     data['fullName'] = this.fullName;
//     data['mobileNumber'] = this.mobileNumber;
//     data['email'] = this.email;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

class FetchProductModel {
  List<ProductList>? productList;

  FetchProductModel({this.productList});

  FetchProductModel.fromJson(Map<String, dynamic> json) {
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productList != null) {
      data['productList'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? status;
  Value? value;

  ProductList({this.status, this.value});

  ProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class Value {
  String? sId;
  String? productName;
  String? productCategory;
  String? productPrice;
  List<String>? images;
  User? user;
  String? productDesc;
  String? createdAt;
  String? updatedAt;
  bool isFavourite = false;
  int? iV;

  Value(
      {this.sId,
      this.productName,
      this.productCategory,
      this.productPrice,
      this.images,
      this.user,
      this.productDesc,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Value.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productCategory = json['productCategory'];
    productPrice = json['productPrice'];
    images = json['images'].cast<String>();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    productDesc = json['productDesc'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productCategory'] = this.productCategory;
    data['productPrice'] = this.productPrice;
    data['images'] = this.images;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['productDesc'] = this.productDesc;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? userName;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.userName,
      this.fullName,
      this.mobileNumber,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    fullName = json['fullName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
