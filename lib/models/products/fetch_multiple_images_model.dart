class FetchMultipleImagesModel {
  List<Files>? files;

  FetchMultipleImagesModel({this.files});

  FetchMultipleImagesModel.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? status;
  String? value;

  Files({this.status, this.value});

  Files.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['value'] = this.value;
    return data;
  }
}