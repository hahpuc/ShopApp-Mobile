import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/code_message_response.dart';
import 'package:furniture_shop/data/model/response/create_order_response.dart';
import 'dart:developer';

import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/demo_response.dart';
import 'package:furniture_shop/data/model/response/get_product_category_response.dart';
import 'package:furniture_shop/data/model/response/order_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/data/model/response/user_address_response.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/data/remote/api_service_helper.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';

import 'package:furniture_shop/utils/utils.dart' as utils;
import 'package:sprintf/sprintf.dart';

class ApiConfigs {
  static const TIME_OUT_SECONDS = 30;
}

class ApiPath {
  static const DEMO = "/v1/abc";
  static const SIGNUP = "/signup/";
  static const SIGNIN = "/signin/";
  static const PRODUCT_DETAIL = "/product/";
  static const USER_CART = "/cart/";
  static const ADD_PRODUCT_CART = "/cart/add-item/";
  static const DELETE_PRODUCT_CART = "/cart/delete/";
  static const USER_ADDRESS = '/user-adresses';
  static const SET_ADDRESS_DEFAULT = '/set-default-address/';
  static const CREATE_ORDER = '/create-order';
  static const CATEGORIES = "/categories";
  static const PRODUCT_BY_CATEGORY = "/category/%s/products?page=%s&limit=%s";
  static const ORDER_BY_STATUS = '/order/status/';
  static const ALL_ORDERS = '/get-order';
}

class ZaloPayConfig {
  static const String appId = "2554";
  static const String key1 = "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn";
  static const String key2 = "trMrHtvjo6myautxDUiAcYsVtaeQ8nhf";

  static const String appUser = "zalopaydemo";
  static int transIdDefault = 1;
}

class ApiService {
  final String baseUrl;
  final ApiServiceHelper _apiServiceHelper = ApiServiceHelper();

  ApiService({required this.baseUrl});

  // =========================== DEMO ===============================
  Future<Result<DemoResponse, Exception>> getDemo() async {
    return _apiServiceHelper.handleResponse<DemoResponse>(request: () async {
      var response = await _apiServiceHelper.get(
          url: 'https://jsonplaceholder.typicode.com/albums/1');
      // Parse data here to BaseResponse
      return DemoResponse.tryParse(response);
    });
  }

  // =========================== PRODUCT DETAIL ===============================
  Future<Result<ProductDetailResponse, Exception>> getProductDetail(
      String productId) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.get(
          url: baseUrl + ApiPath.PRODUCT_DETAIL + productId);

      return ProductDetailResponse().tryParse(response);
    });
  }

  // =========================== SIGN UP ===============================
  Future<Result<UserResponse, Exception>> postUserSignUp(UserModel user) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.post(
          url: baseUrl + ApiPath.SIGNUP, body: user.toSignUpJson());
      return UserResponse().tryParse(response);
    });
  }

  // =========================== SIGN IN ===============================
  Future<Result<UserResponse, Exception>> postUserSignIn(UserModel user) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.post(
          url: baseUrl + ApiPath.SIGNIN, body: user.toSignInJson());
      return UserResponse().tryParse(response);
    });
  }

  // =========================== USER CART ===============================
  Future<Result<MyCartResponse, Exception>> getUserCart() async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response =
          await _apiServiceHelper.get(url: baseUrl + ApiPath.USER_CART);
      return MyCartResponse().tryParse(response);
    });
  }

  Future<Result<MyCartResponse, Exception>> postAddProductToCart(
      ProductDetailModel product, int quantity) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.post(
        url: baseUrl + ApiPath.ADD_PRODUCT_CART,
        body: {
          "productId": product.id,
          "quantity": quantity.toString(),
        },
      );
      return MyCartResponse().tryParse(response);
    });
  }

  Future<Result<MyCartResponse, Exception>> postDeleteProductInCart(
      ProductDetailModel product) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.post(
          url: baseUrl + ApiPath.DELETE_PRODUCT_CART,
          body: product.toDeleteProductJson());
      return MyCartResponse().tryParse(response);
    });
  }

  // =========================== USER ADDRESS ===============================

  Future<Result<UserAddressResponse, Exception>> getUserAddress() {
    return _apiServiceHelper.handleResponse(request: () async {
      var response =
          await _apiServiceHelper.get(url: baseUrl + ApiPath.USER_ADDRESS);

      return UserAddressResponse().tryParse(response);
    });
  }

  Future<Result<CodeMessageResponse, Exception>> setDefaultAddress(String id) {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.post(
        url: baseUrl + ApiPath.SET_ADDRESS_DEFAULT + id,
      );
      return CodeMessageResponse().tryParse(response);
    });
  }

  // =========================== ORDER ===============================
  Future<Result<CodeMessageResponse, Exception>> createOrder(
    ShippingAddressModel address,
    List<ProductModel> items,
    int totalMoney,
    PAYMENT_METHOD method,
  ) {
    return _apiServiceHelper.handleResponse(request: () async {
      var paymentMethod = 1;
      var paid = false;

      if (method == PAYMENT_METHOD.MOMO) {
        paymentMethod = 2;
        paid = true;
      } else if (method == PAYMENT_METHOD.ZALO) {
        paymentMethod = 3;
        paid = true;
      }

      //   print("BODY REQUEST ORDER: ${body.toString()}");

      var response = await _apiServiceHelper.post(
        url: baseUrl + ApiPath.CREATE_ORDER,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
        body: jsonEncode({
          "name": address.name,
          "email": "longnguyen@gmail.com",
          "phone_number": address.phoneNumber,
          "shipping_address": address.address,
          "total_money": totalMoney,
          "payment_method": paymentMethod,
          "paid": paid,
          "items": items.map((item) => item.toRequestOrder()).toList(),
        }),
      );
      return CodeMessageResponse().tryParse(response);
    });
  }

  Future<Result<CreateOrderZaloResponse, Exception>> createZaloOrder(
      int price) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var body = new Map<String, String>();

      body["app_id"] = ZaloPayConfig.appId;
      body["app_user"] = ZaloPayConfig.appUser;
      body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
      body["amount"] = price.toStringAsFixed(0);
      body["app_trans_id"] = utils.getAppTransId();
      body["embed_data"] = "{}";
      body["item"] = "[]";
      body["bank_code"] = utils.getBankCode();
      body["description"] = utils.getDescription(body["app_trans_id"] ?? "");

      var dataGetMac = sprintf("%s|%s|%s|%s|%s|%s|%s", [
        body["app_id"],
        body["app_trans_id"],
        body["app_user"],
        body["amount"],
        body["app_time"],
        body["embed_data"],
        body["item"]
      ]);
      body["mac"] = utils.getMacCreateOrder(dataGetMac);

      var response = await _apiServiceHelper.post(
        url: 'https://sb-openapi.zalopay.vn/v2/create',
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body,
      );
      return CreateOrderZaloResponse().tryParse(response);
    });
  }

  Future<Result<CreateOrderMomoResponse, Exception>> createMomoOrder(
      int price) async {
    return _apiServiceHelper.handleResponse(request: () async {
      //parameters
      var partnerCode = "MOMORWQP20211125";
      var partnerName = "Muard";
      var accessKey = "bOWRkXLqfiwxCmjp";
      var secretkey =
          "KMLlfdzjBCuohh7YOsCmtd081mP7x9Z7"; // To create Signatur Hmac SHA256
      var requestId = partnerCode +
          DateTime.now()
              .millisecondsSinceEpoch
              .toString(); // requestID = partnerCode + Time.now()
      var storeId = "app";
      var orderId = requestId;
      var orderInfo = "pay with MoMo";
      var redirectUrl = "momo-redirect://order-success";
      var ipnUrl = "https://callback.url/notify";
      var amount = price;
      var requestType = "captureWallet";
      var extraData =
          ""; //pass empty value if your merchant does not have stores

      // Signature
      var rawSignature = "accessKey=" +
          accessKey +
          "&amount=" +
          amount.toString() +
          "&extraData=" +
          extraData +
          "&ipnUrl=" +
          ipnUrl +
          "&orderId=" +
          orderId +
          "&orderInfo=" +
          orderInfo +
          "&partnerCode=" +
          partnerCode +
          "&redirectUrl=" +
          redirectUrl +
          "&requestId=" +
          requestId +
          "&requestType=" +
          requestType;

      var signature = Hmac(sha256, secretkey.codeUnits)
          .convert(rawSignature.codeUnits)
          .toString();

      Map requestBody = {
        "partnerCode": partnerCode,
        "partnerName": partnerName,
        "requestId": requestId,
        "storeId": storeId,
        "amount": price,
        "orderId": orderId,
        "orderInfo": orderInfo,
        "redirectUrl": redirectUrl,
        "ipnUrl": ipnUrl,
        "extraData": "",
        "requestType": requestType,
        "signature": signature,
        "lang": "en"
      };

      var response = await _apiServiceHelper.post(
        url: 'https://test-payment.momo.vn/v2/gateway/api/create',
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );
      return CreateOrderMomoResponse().tryParse(response);
    });
  }

  // =========================== CATEGORIES DETAIL ===============================
  Future<Result<CategoriesResponse, Exception>> getCategories() async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response =
          await _apiServiceHelper.get(url: baseUrl + ApiPath.CATEGORIES);
      return CategoriesResponse().tryParse(response);
      // return response;
    });
  }

  // =========================== PRODUCT BY CATEGORY ===============================
  Future<Result<GetProductByCategoryResponse, Exception>> getProductByCategory(
      String id) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.get(
          url: sprintf('$baseUrl${ApiPath.PRODUCT_BY_CATEGORY}', [id, 1, 20]));
      return GetProductByCategoryResponse().tryParse(response);
    });
  }

  // =========================== ORDER ===============================

  Future<Result<OrderResponse, Exception>> getOrderByStatus(int status) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.get(
          url: baseUrl + ApiPath.ORDER_BY_STATUS + status.toString());
      return OrderResponse().tryParse(response);
    });
  }

  Future<Result<OrderResponse, Exception>> getAllOrder() async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response =
          await _apiServiceHelper.get(url: baseUrl + ApiPath.ALL_ORDERS);
      return OrderResponse().tryParse(response);
    });
  }
}
