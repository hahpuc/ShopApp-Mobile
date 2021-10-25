import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';

class HomePageState extends BaseState {}

class HomePageLoadingState extends HomePageState {}

class HomePageGetDataSuccessState extends HomePageState {
  final List<CategoriesResponseData> data;
  HomePageGetDataSuccessState(this.data);
}

class HomePageGetDataFailState extends HomePageState {}
