import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';

class HomeTabPageState extends BaseState {}

class HomeTabPageLoadingState extends HomeTabPageState {}

class HomeTabPageGetDataSuccessState extends HomeTabPageState {
  final List<CategoriesResponseData> data;
  HomeTabPageGetDataSuccessState(this.data);
}

class HomeTabPageGetDataFailState extends HomeTabPageState {}
