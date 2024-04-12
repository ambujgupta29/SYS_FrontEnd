class FetchProfilePictureModel {
  String? filename;
  String? url;

  FetchProfilePictureModel({this.filename, this.url});

  FetchProfilePictureModel.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['url'] = this.url;
    return data;
  }
}