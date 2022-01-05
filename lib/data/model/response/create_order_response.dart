import 'package:furniture_shop/data/model/response/base/base_response.dart';

//----------- ZALO -----------------

class CreateOrderZaloResponse
    extends BaseResponseData<CreateOrderZaloResponseData> {
  @override
  CreateOrderZaloResponseData parseData(dynamic mapData) {
    return CreateOrderZaloResponseData.fromJson(mapData);
  }
}

class CreateOrderZaloResponseData {
  String? zptranstoken;
  String? orderurl;
  int? returncode;
  String? returnmessage;
  int? subreturncode;
  String? subreturnmessage;
  String? ordertoken;

  CreateOrderZaloResponseData({
    this.zptranstoken,
    this.orderurl,
    this.returncode,
    this.returnmessage,
    this.subreturncode,
    this.subreturnmessage,
    this.ordertoken,
  });

  factory CreateOrderZaloResponseData.fromJson(Map<String, dynamic> json) {
    return CreateOrderZaloResponseData(
      zptranstoken: json['zp_trans_token'] as String,
      orderurl: json['order_url'] as String,
      returncode: json['return_code'] as int,
      returnmessage: json['return_message'] as String,
      subreturncode: json['sub_return_code'] as int,
      subreturnmessage: json['sub_return_message'] as String,
      ordertoken: json["order_token"] as String,
    );
  }
}

//----------- MOMO -----------------
class CreateOrderMomoResponse
    extends BaseResponseData<CreateOrderMomoResponseData> {
  @override
  CreateOrderMomoResponseData parseData(dynamic mapData) {
    return CreateOrderMomoResponseData.fromJson(mapData);
  }
}

class CreateOrderMomoResponseData {
  final String? partnerCode;
  final String? orderId;
  final String? requestId;
  final int? amount;
  final int? responseTime;
  final String? message;
  final int? resultCode;
  final String? payUrl;
  final String? deeplink;
  final String? qrCodeUrl;

  CreateOrderMomoResponseData({
    this.partnerCode,
    this.orderId,
    this.requestId,
    this.amount,
    this.responseTime,
    this.message,
    this.resultCode,
    this.payUrl,
    this.deeplink,
    this.qrCodeUrl,
  });

  factory CreateOrderMomoResponseData.fromJson(Map<String, dynamic> json) {
    return CreateOrderMomoResponseData(
      partnerCode: json['partnerCode'] as String?,
      orderId: json['orderId'] as String?,
      requestId: json['requestId'] as String?,
      amount: json['amount'] as int?,
      responseTime: json['responseTime'] as int?,
      message: json['message'] as String?,
      resultCode: json['resultCode'] as int?,
      payUrl: json['payUrl'] as String?,
      deeplink: json['deeplink'] as String?,
      qrCodeUrl: json['qrCodeUrl'] as String?,
    );
  }
}
