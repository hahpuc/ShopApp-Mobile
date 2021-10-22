import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';

class ProductDetailPageState extends BaseState {}

class ProductDetailPageLoadingState extends ProductDetailPageState {}

class ProductDetailPageGetDataSuccessState extends ProductDetailPageState {
  final ProductDetailResponseData data;
  ProductDetailPageGetDataSuccessState(this.data);
}
