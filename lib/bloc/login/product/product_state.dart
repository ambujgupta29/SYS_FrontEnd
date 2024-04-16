import 'package:sys_mobile/common/screen_state.dart';
import 'package:sys_mobile/models/products/fetch_image_model.dart';
import 'package:sys_mobile/models/products/fetch_multiple_images_model.dart';
import 'package:sys_mobile/models/products/fetch_product_id_model.dart';
import 'package:sys_mobile/models/products/fetch_product_model.dart';

abstract class ProductState extends ScreenState {}

class ProductInitial extends ProductState {}

class ProductFailedState extends ProductState {}

//Fetch all Product

class FetchAllProductProgressState extends ProductState {}

class FetchAllProductFailedState extends ProductState {
  String message;
  FetchAllProductFailedState(this.message);
}

class FetchAllProductSuccessState extends ProductState {
  FetchProductModel fetchProductModel;
  FetchAllProductSuccessState(this.fetchProductModel);
}

//fetch product by user

class FetchUserProductsProgressState extends ProductState {}

class FetchUserProductsFailedState extends ProductState {
  String message;
  FetchUserProductsFailedState(this.message);
}

class FetchUserProductsSuccessState extends ProductState {
  FetchProductModel fetchProductModel;
  FetchUserProductsSuccessState(this.fetchProductModel);
}

//fetch image

class FetchImageProgressState extends ProductState {}

class FetchImageFailedState extends ProductState {
  String message;
  FetchImageFailedState(this.message);
}

class FetchImageSuccessState extends ProductState {
  FetchImageModel fetchImageModel;
  FetchImageSuccessState(this.fetchImageModel);
}

class FetchMultipleImagesProgressState extends ProductState {}

class FetchMultipleImagesFailedState extends ProductState {
  String message;
  FetchMultipleImagesFailedState(this.message);
}

class FetchMultipleImagesSuccessState extends ProductState {
  FetchMultipleImagesModel fetchMultipleImagesModel;
  FetchMultipleImagesSuccessState(this.fetchMultipleImagesModel);
}

class PostProductProgressState extends ProductState {}

class PostProductFailedState extends ProductState {
  String message;
  PostProductFailedState(this.message);
}

class PostProductSuccessState extends ProductState {
  String message;
  PostProductSuccessState(this.message);
}


class FetchProductByIDProgressState extends ProductState {}

class FetchProductByIDFailedState extends ProductState {
  String message;
  FetchProductByIDFailedState(this.message);
}

class FetchProductByIDSuccessState extends ProductState {
  FetchProductByIdModel fetchProductModel;
  FetchProductByIDSuccessState(this.fetchProductModel);
}



class GetMaxPriceProgressState extends ProductState {}

class GetMaxPriceFailedState extends ProductState {
  String message;
  GetMaxPriceFailedState(this.message);
}

class GetMaxPriceSuccessState extends ProductState {
  String maxPrice;
  GetMaxPriceSuccessState(this.maxPrice);
}
