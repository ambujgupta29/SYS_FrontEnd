import 'package:sys_mobile/common/screen_state.dart';
import 'package:sys_mobile/models/products/fetch_profile_picture_model.dart';

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
