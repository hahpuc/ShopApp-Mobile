import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/payment_method_state.dart';

class PaymentMethodPageBloc extends BlocBase<PaymentMethodPageState> {
  final AppRepository appRepository;

  PaymentMethodPageBloc({required this.appRepository})
      : super(PaymentMethodPageState());

  PAYMENT_METHOD? paymentMethod;
  changePaymentMethod(PAYMENT_METHOD? method) {
    paymentMethod = method;
    emit(PaymentMethodPageGetDataSuccessState(paymentMethod: method));
  }

  Future<void> loadData() async {
    emit(PaymentMethodPageLoadingState());
    if (paymentMethod == null) {
      paymentMethod = PAYMENT_METHOD.MOMO;
    }
    emit(PaymentMethodPageGetDataSuccessState(paymentMethod: paymentMethod));
  }
}
