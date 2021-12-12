import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';

class HomeTabPageState extends BaseState {}

class HomeTabPageLoadingState extends HomeTabPageState {}

class HomeTabPageGetDataSuccessState extends HomeTabPageState {
  final List<CategoriesModel> data;
  HomeTabPageGetDataSuccessState(this.data);
}

class HomeTabPageGetDataFailState extends HomeTabPageState {
  final String msg;
  HomeTabPageGetDataFailState(this.msg);
}
