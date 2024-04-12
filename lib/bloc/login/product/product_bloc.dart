import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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
    if (event is FetchUserProductsEvent) {
      yield* _handleFetchUserProductsEvent(event);
    }
    if (event is FetchImageEvent) {
      yield* _handleFetchImageEvent(event);
    }
    if (event is FetchMultipleImagesEvent) {
      yield* _handleFetchMultipleImagesEvent(event);
    }
    if (event is PostProductEvent) {
      yield* _handlePostProductEvent(event);
    }
  }

  Stream<ProductState> _handleFetchAllProductEvent(
      FetchAllProductsEvent event) async* {
    yield FetchAllProductProgressState();
    try {
      Map<String, dynamic> body = {
        "productName": event.productName,
      };
      final Response response =
          await ProductRepository().fetchAllProducts(body);
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
      final Response response =
          await ProductRepository().fetchMultipleImages(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchImageModel =
            FetchMultipleImagesModel.fromJson(response.data);
        yield FetchMultipleImagesSuccessState(fetchImageModel);
      }
    } on Exception catch (ex) {
      yield FetchMultipleImagesFailedState(ex.toString());
    }
  }

  Stream<ProductState> _handlePostProductEvent(PostProductEvent event) async* {
    yield PostProductProgressState();
    try {
      List<dynamic> files = [];
      if (event.images != null && event.images!.isNotEmpty) {
        (event.images)?.forEach(
          (e) => print(e),
        );
        (event.images)!.forEach((e) {
          // files.add(File(e));
          // var file =  MultipartFile.fromFileSync(File(e).path,
          //     filename: (File(e).path.split('/').last));
          files.add(
            MultipartFile.fromFileSync(File(e).path,
                filename: (File(e).path.split('/').last),
                contentType: MediaType('image', '*')),
          );
        });
      }
      FormData body = FormData.fromMap({
        "productName": event.productName,
        "productCategory": event.productCategory,
        "productDesc": event.productDesc,
        "productPrice": event.productPrice,
        "files": event.images != null ? files : null,
      });
      final Response response = await ProductRepository().postProduct(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = (response.data['message']);
        yield PostProductSuccessState(message);
      }
    } on Exception catch (ex) {
      yield PostProductFailedState(ex.toString());
    }
  }

  Stream<ProductState> _handleFetchUserProductsEvent(
      FetchUserProductsEvent event) async* {
    yield FetchUserProductsProgressState();
    try {
      final Response response = await ProductRepository().getuserPost();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchProductModel = FetchProductModel.fromJson(response.data);
        yield FetchUserProductsSuccessState(fetchProductModel);
      }
    } on Exception catch (ex) {
      yield FetchUserProductsFailedState(ex.toString());
    }
  }
}
