import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';

class HomeTabAdminPageState extends BaseState {}

class HomeTabAdminPageLoadingState extends HomeTabAdminPageState {}

class HomeTabAdminPageGetDataSuccessState extends HomeTabAdminPageState {
  List<ProductDetailModel>? data;
  HomeTabAdminPageGetDataSuccessState(this.data);
}

class HomeTabAdminPageGetDataFailState extends HomeTabAdminPageState {
  final String msg;
  HomeTabAdminPageGetDataFailState(this.msg);
}
