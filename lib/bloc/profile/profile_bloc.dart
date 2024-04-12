import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';

import 'package:sys_mobile/common/base_bloc.dart';
import 'package:sys_mobile/models/products/fetch_profile_picture_model.dart';
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
    if (event is UploadProfilePictureEvent) {
      yield* _handleUploadProfilePictureEvent(event);
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
}
