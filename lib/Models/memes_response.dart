class MemesResponse {
  bool? success;
  Data? data;

  MemesResponse({this.success, this.data});

  MemesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<MemeData>? memes;

  Data({this.memes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['memes'] != null) {
      memes = <MemeData>[];
      json['memes'].forEach((v) {
        memes!.add(MemeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (memes != null) {
      data['memes'] = memes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemeData {
  String? id;
  String? name;
  String? url;
  int? width;
  int? height;
  int? boxCount;

  MemeData(
      {this.id, this.name, this.url, this.width, this.height, this.boxCount});

  MemeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    boxCount = json['box_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    data['box_count'] = boxCount;
    return data;
  }
}
