import 'package:furniture_shop/data/model/response/base/base_response.dart';

class CategoriesResponse extends BaseResponseData<CategoriesResponseData> {
  @override
  CategoriesResponseData parseData(data) {
    // TODO: implement parseData
    throw UnimplementedError();
  }
}

class CategoriesResponseData {
  final int id;
  final String name;
  final String image;

  CategoriesResponseData(
      {required this.id, required this.name, required this.image});

  factory CategoriesResponseData.fromMap(Map<String, dynamic> map) {
    return CategoriesResponseData(
      id: map["id"] as int,
      name: map["id"] as String,
      image: map["image"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": this.id, "name": this.name, "image": this.image};
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
