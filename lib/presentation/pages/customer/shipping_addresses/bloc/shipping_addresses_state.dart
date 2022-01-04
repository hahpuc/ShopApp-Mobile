import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';

class ShippingAddressPageState extends BaseState {}

class ShippingAddressPageLoadingState extends ShippingAddressPageState {}

class ShippingAddressPageGetDataSuccessState extends ShippingAddressPageState {
  List<ShippingAddressModel> data;

  ShippingAddressPageGetDataSuccessState(this.data);
}

class ShippingAddressPageGetDataErrorState extends ShippingAddressPageState {
  String msg;
  ShippingAddressPageGetDataErrorState(this.msg);
}

class SetAddressDefaultSuccessState extends ShippingAddressPageState {}

class SetAddressDefaultErrorState extends ShippingAddressPageState {
  String msg;
  SetAddressDefaultErrorState(this.msg);
}

class SetAddressToLocalSuccessState extends ShippingAddressPageState {}
