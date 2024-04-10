import 'package:dio/dio.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';
import 'package:sys_mobile/bloc/login/product/product_state.dart';

import 'package:sys_mobile/common/base_bloc.dart';
import 'package:sys_mobile/models/products/fetch_image_model.dart';
import 'package:sys_mobile/models/products/fetch_multiple_images_model.dart';
import 'package:sys_mobile/models/products/fetch_product_model.dart';
import 'package:sys_mobile/repository/product_repository.dart';

class ProductsBloc extends BaseBloc<ProductEvent, ProductState> {
  ProductsBloc() : super(ProductInitial());

  @override
  ProductState getErrorState() => ProductFailedState();

  @override
  Stream<ProductState> handleEvents(ProductEvent event) async* {
    if (event is FetchAllProductsEvent) {
      yield* _handleFetchAllProductEvent(event);
    }
    if (event is FetchImageEvent) {
      yield* _handleFetchImageEvent(event);
    }
    if (event is FetchMultipleImagesEvent) {
      yield* _handleFetchMultipleImagesEvent(event);
    }
  }

  Stream<ProductState> _handleFetchAllProductEvent(
      FetchAllProductsEvent event) async* {
    yield FetchAllProductProgressState();
    try {
      final Response response = await ProductRepository().fetchAllProducts();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchProductModel = FetchProductModel.fromJson(response.data);
        yield FetchAllProductSuccessState(fetchProductModel);
      }
    } on Exception catch (ex) {
      yield FetchAllProductFailedState(ex.toString());
    }
  }

  Stream<ProductState> _handleFetchImageEvent(FetchImageEvent event) async* {
    yield FetchImageProgressState();
    try {
      Map<String, dynamic> body = {
        'fileName': event.fileName,
      };
      final Response response = await ProductRepository().fetchImage(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchImageModel = FetchImageModel.fromJson(response.data);
        yield FetchImageSuccessState(fetchImageModel);
      }
    } on Exception catch (ex) {
      yield FetchImageFailedState(ex.toString());
    }
  }

  Stream<ProductState> _handleFetchMultipleImagesEvent(
      FetchMultipleImagesEvent event) async* {
    yield FetchMultipleImagesProgressState();
    try {
      Map<String, dynamic> body = {
        'fileName': event.fileName,
      };
      final Response response = await ProductRepository().fetchMultipleImages(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchImageModel =
            FetchMultipleImagesModel.fromJson(response.data);
        yield FetchMultipleImagesSuccessState(fetchImageModel);
      }
    } on Exception catch (ex) {
      yield FetchMultipleImagesFailedState(ex.toString());
    }
  }
}
