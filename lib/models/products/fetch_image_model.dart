class FetchImageModel {
  Files? files;

  FetchImageModel({this.files});

  FetchImageModel.fromJson(Map<String, dynamic> json) {
    files = json['files'] != null ? new Files.fromJson(json['files']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files!.toJson();
    }
    return data;
  }
}

class Files {
  String? filename;
  String? url;

  Files({this.filename, this.url});

  Files.fromJson(Map<String, dynamic> json) {
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