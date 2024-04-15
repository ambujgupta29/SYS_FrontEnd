abstract class ProfileEvent {}

//Get profile pic

class GetProfilePictureEvent extends ProfileEvent {
  GetProfilePictureEvent();
}

class UploadProfilePictureEvent extends ProfileEvent {
  var file;
  UploadProfilePictureEvent(this.file);
}

class GetUserInfoEvent extends ProfileEvent {
  GetUserInfoEvent();
}

class RemoveItemFromFavEvent extends ProfileEvent {
  final String productId;
  RemoveItemFromFavEvent({required this.productId});
}

class AddItemToFavEvent extends ProfileEvent {
  final String productId;
  AddItemToFavEvent({required this.productId});
}

class GetFavListEvent extends ProfileEvent {
  GetFavListEvent();
}


class RemoveItemFromCartEvent extends ProfileEvent {
  final String productId;
  RemoveItemFromCartEvent({required this.productId});
}

class AddItemToCartEvent extends ProfileEvent {
  final String productId;
  AddItemToCartEvent({required this.productId});
}