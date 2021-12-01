import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';

class ProductDetailPageState extends BaseState {}

class ProductDetailPageLoadingState extends ProductDetailPageState {}

class ProductDetailGetDataSuccess extends ProductDetailPageState {
  final ProductDetailModel data;

  ProductDetailGetDataSuccess(this.data);
}

class ProductDetailGetDataFailed extends ProductDetailPageState {
  final String msg;

  ProductDetailGetDataFailed(this.msg);
}
