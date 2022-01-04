import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';

class WishList {
  List<ProductDetailModel> list = [];

  toJSON() {
    return list.map((item) {
      return item.toJson();
    }).toList();
  }
}
