import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/order_response.dart';

class OrderPageState extends BaseState {}

class OrderPageLoadingState extends OrderPageState {}

class OrderPageSuccessState extends OrderPageState {
  List<OrderDataModel> data;

  OrderPageSuccessState(this.data);
}

class OrderPageFailedState extends OrderPageState {
  final String msg;

  OrderPageFailedState(this.msg);
}
