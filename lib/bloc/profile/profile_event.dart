abstract class ProfileEvent {}

//Get profile pic

class GetProfilePictureEvent extends ProfileEvent {
  GetProfilePictureEvent();
}

class UploadProfilePictureEvent extends ProfileEvent {
  var file;
  UploadProfilePictureEvent(this.file);
}
