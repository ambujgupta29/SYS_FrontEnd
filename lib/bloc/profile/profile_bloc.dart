import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';

import 'package:sys_mobile/common/base_bloc.dart';
import 'package:sys_mobile/models/products/fetch_profile_picture_model.dart';
import 'package:sys_mobile/models/products/user_info_model.dart';
import 'package:sys_mobile/repository/profile_repository.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  ProfileState getErrorState() => ProfileFailedState();

  @override
  Stream<ProfileState> handleEvents(ProfileEvent event) async* {
    if (event is GetProfilePictureEvent) {
      yield* _handleGetProfilePictureEvent(event);
    }
    if (event is GetUserInfoEvent) {
      yield* _handleGetUserInfoEvent(event);
    }
    if (event is GetFavListEvent) {
      yield* _handleGetFavListEvent(event);
    }
    if (event is UploadProfilePictureEvent) {
      yield* _handleUploadProfilePictureEvent(event);
    }
    if (event is RemoveItemFromFavEvent) {
      yield* _handleRemoveItemFromFavEvent(event);
    }
    if (event is AddItemToFavEvent) {
      yield* _handleAddItemToFavEvent(event);
    }
  }

  Stream<ProfileState> _handleGetProfilePictureEvent(
      GetProfilePictureEvent event) async* {
    yield GetProfilePictureProgressState();
    try {
      final Response response = await ProfileRepository().getProfilePic();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchProfilepictureModel =
            FetchProfilePictureModel.fromJson(response.data);
        yield GetProfilePictureSuccessState(fetchProfilepictureModel);
      }
    } on Exception catch (ex) {
      yield GetProfilePictureFailedState(ex.toString());
    }
  }

  Stream<ProfileState> _handleUploadProfilePictureEvent(
      UploadProfilePictureEvent event) async* {
    yield UploadProfilePictureProgressState();
    try {
      String fileName = '';
      String pathName = '';
      if (event.file != null) {
        fileName = event.file.path.split('/').last;
        pathName = event.file.path;
        print(fileName);
      }
      FormData body = FormData.fromMap({
        'file': event.file != null
            ? await MultipartFile.fromFile(pathName,
                filename: fileName, contentType: MediaType('image', '*'))
            : null,
      });
      final Response response =
          await ProfileRepository().uploadProfilePic(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = (response.data['message']);
        yield UploadProfilePictureSuccessState(message);
      }
    } on Exception catch (ex) {
      yield UploadProfilePictureFailedState(ex.toString());
    }
  }

  Stream<ProfileState> _handleGetUserInfoEvent(GetUserInfoEvent event) async* {
    yield GetUserInfoProgressState();
    try {
      final Response response = await ProfileRepository().getUserInfo();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchUserInfoModel = FetchUserInfoModel.fromJson(response.data);
        yield GetUserInfoSuccessState(fetchUserInfoModel);
      }
    } on Exception catch (ex) {
      yield GetUserInfoFailedState(ex.toString());
    }
  }

  Stream<ProfileState> _handleAddItemToFavEvent(
      AddItemToFavEvent event) async* {
    yield AddItemToFavProgressState();
    try {
      Map<String, dynamic> body = {
        'ProductId': event.productId,
      };
      final Response response = await ProfileRepository().addToFav(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchUserInfoModel = FetchUserInfoModel.fromJson(response.data);
        yield AddItemToFavSuccessState(fetchUserInfoModel);
      }
    } on Exception catch (ex) {
      yield AddItemToFavFailedState(ex.toString());
    }
  }

  Stream<ProfileState> _handleRemoveItemFromFavEvent(
      RemoveItemFromFavEvent event) async* {
    yield RemoveItemFromFavProgressState();
    try {
      Map<String, dynamic> body = {
        'ProductId': event.productId,
      };
      final Response response = await ProfileRepository().removeFromFav(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchUserInfoModel = FetchUserInfoModel.fromJson(response.data);
        yield RemoveItemFromFavSuccessState(fetchUserInfoModel);
      }
    } on Exception catch (ex) {
      yield RemoveItemFromFavFailedState(ex.toString());
    }
  }

  Stream<ProfileState> _handleGetFavListEvent(GetFavListEvent event) async* {
    yield GetFavListProgressState();
    try {
      final Response response = await ProfileRepository().getUserInfo();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fetchFavListModel = FetchUserInfoModel.fromJson(response.data);
        yield GetFavListSuccessState(fetchFavListModel);
      }
    } on Exception catch (ex) {
      yield GetFavListFailedState(ex.toString());
    }
  }
}
