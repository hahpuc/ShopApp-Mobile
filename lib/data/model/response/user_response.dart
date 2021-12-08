import 'package:furniture_shop/data/model/response/base/base_response.dart';

class UserResponse extends BaseResponseData<UserResponseData> {
  @override
  UserResponseData parseData(data) {
    // TODO: implement parseData
    throw UnimplementedError();
  }
}

class UserResponseData {
  int? code;
  String? message;
  UserModel? data;

  String? accessToken;
  String? refreshToken;

  UserResponseData(
      {this.code,
      this.message,
      this.data,
      this.accessToken,
      this.refreshToken});

  UserResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserModel {
  int? userId;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  int? totalAddress;
  List<ShippingAddressModel>? shippingAddress;
  int? paymentMethod;
  int? role;

  UserModel(
      {this.userId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.totalAddress,
      this.shippingAddress,
      this.paymentMethod,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    totalAddress = json['total_address'];
    if (json['shipping_address'] != null) {
      shippingAddress = [];
      json['shipping_address'].forEach((e) {
        shippingAddress?.add(new ShippingAddressModel.fromJson(e));
      });
    }
    paymentMethod = json['payment_method'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['_id'] = this.userId;
    map['name'] = this.name;
    map['email'] = this.email;
    map['password'] = this.password;
    map['phone_number'] = this.phoneNumber;
    map['total_address'] = this.totalAddress;
    if (this.shippingAddress != null) {
      map['shipping_address'] =
          this.shippingAddress!.map((v) => v.toJson()).toList();
    }
    map['payment_method'] = this.paymentMethod;
    map['role'] = this.role;
    return map;
  }
}

class ShippingAddressModel {
  String? id;
  String? isDefault;
  String? name;
  String? address;
  String? phoneNumber;

  ShippingAddressModel(
      {this.id, this.isDefault, this.name, this.address, this.phoneNumber});

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isDefault = json['isDefault'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map['_id'] = this.id;
    map['isDefault'] = this.isDefault;
    map['name'] = this.name;
    map['address'] = this.address;
    map['phoneNumber'] = this.phoneNumber;

    return map;
  }
}
