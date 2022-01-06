import 'dart:developer';

import 'package:furniture_shop/data/model/response/base/base_response.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/demo_response.dart';
import 'package:furniture_shop/data/model/response/get_product_category_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/data/remote/api_service_helper.dart';
import 'package:sprintf/sprintf.dart';

class ApiConfigs {
  static const TIME_OUT_SECONDS = 30;
}

class ApiPath {
  static const DEMO = "/v1/abc";

  static const PRODUCT_DETAIL = "/product/";
  static const CATEGORIES = "/categories";
  static const PRODUCT_BY_CATEGORY = "/category/%s/products?page=%s&limit=%s";
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
}
