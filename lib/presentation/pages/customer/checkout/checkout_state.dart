import 'package:furniture_shop/bloc/base/base_state.dart';

class CheckOutPageState extends BaseState {}

class CheckOutPageLoadingState extends CheckOutPageState {}

class CheckOutPageGetDataSuccessState extends CheckOutPageState {
//   final List<CheckOutResponseData> data;
//   CheckOutPageGetDataSuccessState(this.data);
}

class CheckOutPageGetDataErrorState extends CheckOutPageState {
  String msg;
  CheckOutPageGetDataErrorState(this.msg);
}
