import 'package:furniture_shop/data/model/response/base/base_response.dart';

class CategoriesResponse extends BaseResponseData<CategoriesResponseData> {
  @override
  CategoriesResponseData parseData(dynamic mapData) {
    return CategoriesResponseData.fromJson(mapData);
  }
}

class CategoriesResponseData {
  int? code;
  String? message;
  List<CategoriesModel>? data;

  CategoriesResponseData({
    this.code,
    this.message,
    this.data,
  });

  CategoriesResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    // data = json['data'] != null
    //     ? new List<CategoriesModel>.from(json.map((key, value) => json.fromJson(value)))
    //     : null;
    if (json['data'] != null) {
      data = [];

      json['data'].forEach((element) {
        data?.add(new CategoriesModel.fromJson(element));
      });
    }
  }
}

class CategoriesModel {
  String? id;
  String? name;
  String? image;

  CategoriesModel(
      {this.id, this.name, this.image = 'assets/images/ic_armchair.svg'});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['_id'] = this.id;
    map['name'] = this.name;
    map['image'] = this.id;

    return map;
  }
}
