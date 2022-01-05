import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';

class CheckOutPageState extends BaseState {}

class CheckOutPageLoadingState extends CheckOutPageState {}

class CheckOutPageGetUserAddress extends CheckOutPageState {
  ShippingAddressModel address;
  CheckOutPageGetUserAddress(this.address);
}

class CheckOutPageGetPaymentMethod extends CheckOutPageState {
  String method;
  CheckOutPageGetPaymentMethod(this.method);
}

class CheckOutPageGetDataSuccessState extends CheckOutPageState {
//   final List<CheckOutResponseData> data;
//   CheckOutPageGetDataSuccessState(this.data);
}

class CheckOutPageGetDataErrorState extends CheckOutPageState {
  String msg;
  CheckOutPageGetDataErrorState(this.msg);
}

class CheckOutPageCreateOrderSuccess extends CheckOutPageState {}

class CheckOutPageCreateOrderError extends CheckOutPageState {
  String msg;
  CheckOutPageCreateOrderError(this.msg);
}
