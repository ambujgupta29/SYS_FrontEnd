abstract class ProductEvent {}

//Does Mobile number exist Event

class FetchAllProductsEvent extends ProductEvent {
  FetchAllProductsEvent();
}

class FetchImageEvent extends ProductEvent {
  String fileName;
  FetchImageEvent({required this.fileName});
}

class FetchMultipleImagesEvent extends ProductEvent {
  List<String> fileName;
  FetchMultipleImagesEvent({required this.fileName});
}

// User Product Event


