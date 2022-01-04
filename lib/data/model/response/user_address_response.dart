import 'package:furniture_shop/data/model/response/user_response.dart';

import 'base/base_response.dart';

class UserAddressResponse extends BaseResponseData<UserAddressResponseData> {
  @override
  UserAddressResponseData parseData(dynamic mapData) {
    return UserAddressResponseData.fromJson(mapData);
  }
}

class UserAddressResponseData {
  int? code;
  List<ShippingAddressModel>? data;

  UserAddressResponseData({
    this.code,
    this.data,
  });

  UserAddressResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      (json['data'] as List).forEach((v) {
        data?.add(new ShippingAddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
