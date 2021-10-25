import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';

class CategoriesResponse extends BaseResponseData<CategoriesResponseData> {}

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
