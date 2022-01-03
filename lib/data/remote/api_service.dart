import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/demo_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/data/remote/api_service_helper.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:http/http.dart';

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
}
