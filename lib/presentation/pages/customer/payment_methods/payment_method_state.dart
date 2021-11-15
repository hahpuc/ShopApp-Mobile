import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';

class PaymentMethodPageState extends BaseState {}

class PaymentMethodPageLoadingState extends PaymentMethodPageState {}

class PaymentMethodPageGetDataSuccessState extends PaymentMethodPageState {
  PAYMENT_METHOD? paymentMethod;
  PaymentMethodPageGetDataSuccessState({this.paymentMethod});
}

class PaymentMethodPageGetDataFailState extends PaymentMethodPageState {}
