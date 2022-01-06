import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';

class OrderResponse extends BaseResponseData<OrderResponseData> {
  @override
  OrderResponseData parseData(dynamic mapData) {
    return OrderResponseData.fromJson(mapData);
  }
}

class OrderResponseData {
  int? code;
  List<OrderDataModel>? data;

  OrderResponseData({
    this.code,
    this.data,
  });

  OrderResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new OrderDataModel.fromJson(v));
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

class OrderDataModel {
  String? orderTime;
  String? paymentTime;
  String? shipTime;
  String? completedTime;
  String? cancelTime;
  String? id;
  String? orderCode;
  int? statusCode;
  List<StatusModel>? statusList;
  String? name;
  String? email;
  String? phoneNumber;
  String? shippingAddress;
  int? totalMoney;
  int? paymentMethod;
  bool? paid;
  List<ProductModel>? items;

  OrderDataModel({
    this.orderTime,
    this.paymentTime,
    this.shipTime,
    this.completedTime,
    this.cancelTime,
    this.id,
    this.orderCode,
    this.statusCode,
    this.statusList,
    this.name,
    this.email,
    this.phoneNumber,
    this.shippingAddress,
    this.totalMoney,
    this.paymentMethod,
    this.paid,
    this.items,
  });

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    orderTime = json['order_time'];
    paymentTime = json['payment_time'];
    shipTime = json['ship_time'];
    completedTime = json['completed_time'];
    cancelTime = json['cancel_time'];
    id = json['_id'];
    orderCode = json['order_code'];
    statusCode = json['status_code'];
    if (json['status_list'] != null) {
      statusList = [];
      json['status_list'].forEach((v) {
        statusList?.add(new StatusModel.fromJson(v));
      });
    }
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    shippingAddress = json['shipping_address'];
    totalMoney = json['total_money'];
    paymentMethod = json['payment_method'];
    paid = json['paid'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_time'] = this.orderTime;
    data['payment_time'] = this.paymentTime;
    data['ship_time'] = this.shipTime;
    data['completed_time'] = this.completedTime;
    data['cancel_time'] = this.cancelTime;
    data['_id'] = this.id;
    data['order_code'] = this.orderCode;
    data['status_code'] = this.statusCode;
    if (this.statusList != null) {
      data['status_list'] = this.statusList?.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['shipping_address'] = this.shippingAddress;
    data['total_money'] = this.totalMoney;
    data['payment_method'] = this.paymentMethod;
    data['paid'] = this.paid;
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusModel {
  int? id;
  String? desciption;
  String? time;

  StatusModel({
    this.id,
    this.desciption,
    this.time,
  });

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    desciption = json['desciption'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['desciption'] = this.desciption;
    data['time'] = this.time;
    return data;
  }
}
