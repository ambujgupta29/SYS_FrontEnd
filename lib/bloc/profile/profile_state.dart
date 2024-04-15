import 'package:sys_mobile/common/screen_state.dart';
import 'package:sys_mobile/models/products/fetch_profile_picture_model.dart';
import 'package:sys_mobile/models/products/user_info_model.dart';

abstract class ProfileState extends ScreenState {}

class ProfileInitial extends ProfileState {}

class ProfileFailedState extends ProfileState {}

//Get Profile Pic

class GetProfilePictureProgressState extends ProfileState {}

class GetProfilePictureFailedState extends ProfileState {
  String message;
  GetProfilePictureFailedState(this.message);
}

class GetProfilePictureSuccessState extends ProfileState {
  FetchProfilePictureModel fetchProfilePictureModel;
  GetProfilePictureSuccessState(this.fetchProfilePictureModel);
}

class UploadProfilePictureProgressState extends ProfileState {}

class UploadProfilePictureFailedState extends ProfileState {
  String message;
  UploadProfilePictureFailedState(this.message);
}

class UploadProfilePictureSuccessState extends ProfileState {
  String message;
  UploadProfilePictureSuccessState(this.message);
}

class GetUserInfoProgressState extends ProfileState {}

class GetUserInfoFailedState extends ProfileState {
  String message;
  GetUserInfoFailedState(this.message);
}

class GetUserInfoSuccessState extends ProfileState {
  FetchUserInfoModel fetchUserInfoModel;
  GetUserInfoSuccessState(this.fetchUserInfoModel);
}

class AddItemToFavProgressState extends ProfileState {}

class AddItemToFavFailedState extends ProfileState {
  String message;
  AddItemToFavFailedState(this.message);
}

class AddItemToFavSuccessState extends ProfileState {
  FetchUserInfoModel fetchUserInfoModel;
  AddItemToFavSuccessState(this.fetchUserInfoModel);
}

class RemoveItemFromFavProgressState extends ProfileState {}

class RemoveItemFromFavFailedState extends ProfileState {
  String message;
  RemoveItemFromFavFailedState(this.message);
}

class RemoveItemFromFavSuccessState extends ProfileState {
  FetchUserInfoModel fetchUserInfoModel;
  RemoveItemFromFavSuccessState(this.fetchUserInfoModel);
}

class GetFavListProgressState extends ProfileState {}

class GetFavListFailedState extends ProfileState {
  String message;
  GetFavListFailedState(this.message);
}

class GetFavListSuccessState extends ProfileState {
  FetchUserInfoModel fetchFavListModel;
  GetFavListSuccessState(this.fetchFavListModel);
}



class AddItemToCartProgressState extends ProfileState {}

class AddItemToCartFailedState extends ProfileState {
  String message;
  AddItemToCartFailedState(this.message);
}

class AddItemToCartSuccessState extends ProfileState {
  FetchUserInfoModel fetchUserInfoModel;
  AddItemToCartSuccessState(this.fetchUserInfoModel);
}

class RemoveItemFromCartProgressState extends ProfileState {}

class RemoveItemFromCartFailedState extends ProfileState {
  String message;
  RemoveItemFromCartFailedState(this.message);
}

class RemoveItemFromCartSuccessState extends ProfileState {
  FetchUserInfoModel fetchUserInfoModel;
  RemoveItemFromCartSuccessState(this.fetchUserInfoModel);
}
