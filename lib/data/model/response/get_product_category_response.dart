import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';

class GetProductByCategoryResponse
    extends BaseResponseData<GetCardByCategoryResponseData> {
  @override
  GetCardByCategoryResponseData parseData(dynamic mapData) {
    return GetCardByCategoryResponseData.fromJson(mapData);
  }
}

class GetCardByCategoryResponseData {
  int? code;
  String? message;

  List<ProductDetailModel>? data;
  int? total;
  int? limit;
  int? page;
  int? pages;

  GetCardByCategoryResponseData({
    this.code,
    this.message,
    this.data,
  });

  GetCardByCategoryResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data']['docs'].forEach((v) {
        data?.add(new ProductDetailModel.fromJson(v));
      });
    }
    total = json['data']['total'];
    limit = json['data']['limit'];
    page = json['data']['page'];
    pages = json['data']['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data']['docs'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
