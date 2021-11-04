import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';

class MyCartPageState extends BaseState {}

class MyCartPageLoadingState extends MyCartPageState {}

class MyCartPageGetDataSuccessState extends MyCartPageState {
  final List<MyCartResponseData> data;
  MyCartPageGetDataSuccessState(this.data);
}
