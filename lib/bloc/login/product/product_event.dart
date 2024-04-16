abstract class ProductEvent {}

//Does Mobile number exist Event

class FetchAllProductsEvent extends ProductEvent {
  final String productName;
  final String productCategory;
  final double minValue;
  final double maxValue;
  FetchAllProductsEvent(
      {required this.productName,
      required this.productCategory,
      required this.minValue,
      required this.maxValue});
}

class FetchUserProductsEvent extends ProductEvent {
  FetchUserProductsEvent();
}

class FetchImageEvent extends ProductEvent {
  String fileName;
  FetchImageEvent({required this.fileName});
}

class FetchMultipleImagesEvent extends ProductEvent {
  List<String> fileName;
  FetchMultipleImagesEvent({required this.fileName});
}

class PostProductEvent extends ProductEvent {
  final String productName;
  final String productCategory;
  final String productPrice;
  String? productDesc;
  List<String>? images;
  PostProductEvent(
      {required this.productName,
      required this.productCategory,
      required this.productPrice,
      this.productDesc,
      this.images});
}

class FetchProductByIDEvent extends ProductEvent {
  final List<String> productIdList;
  FetchProductByIDEvent({required this.productIdList});
}

class GetMaxPriceEvent extends ProductEvent {
  GetMaxPriceEvent();
}
// User Product Event


