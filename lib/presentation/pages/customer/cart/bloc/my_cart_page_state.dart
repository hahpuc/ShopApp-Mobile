import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';

class MyCartPageState extends BaseState {}

class MyCartPageLoadingState extends MyCartPageState {}

class MyCartPageGetDataSuccessState extends MyCartPageState {
  final MyCartResponseModel data;

  MyCartPageGetDataSuccessState(this.data);
}

class MyCardPageGetDataFailedState extends MyCartPageState {
  final String msg;

  MyCardPageGetDataFailedState(this.msg);
}

class MyCartDeleteItemSuccessState extends MyCartPageState {
  final String msg;

  MyCartDeleteItemSuccessState(this.msg);
}

class MyCartDeleteItemFailedState extends MyCartPageState {
  final String msg;

  MyCartDeleteItemFailedState(this.msg);
}
