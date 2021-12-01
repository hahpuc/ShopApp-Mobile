import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/demo_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/data/remote/api_service_helper.dart';
import 'package:http/http.dart';

class ApiConfigs {
  static const TIME_OUT_SECONDS = 30;
}

class ApiPath {
  static const DEMO = "/v1/abc";

  static const PRODUCT_DETAIL = "/product/";
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
}
