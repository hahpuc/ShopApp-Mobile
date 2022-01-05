import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_state.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';
import 'package:furniture_shop/values/app_utils.dart';

class CheckOutPageBloc extends BaseBloc<CheckOutPageState> {
  final AppRepository appRepository;
  CheckOutPageBloc({required this.appRepository}) : super(CheckOutPageState());

  void getUserAddress() async {
    emit(CheckOutPageLoadingState());

    await Future.delayed(Duration(seconds: 1));

    var address = AppUtils.getDefaultAddress();

    emit(CheckOutPageGetUserAddress(address));

    getPaymentMethod();
  }

  void getPaymentMethod() async {
    var method = AppUtils.getPaymentMethod();

    emit(CheckOutPageGetPaymentMethod(method));
  }

  void checkoutOrder(ShippingAddressModel address, List<ProductModel> items,
      int totalMoney, PAYMENT_METHOD method) async {
    emit(CheckOutPageLoadingState());

    var response = await appRepository.apiService
        .createOrder(address, items, totalMoney, method);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      if (resultData?.code == 200) emit(CheckOutPageCreateOrderSuccess());
    } else {
      emit(CheckOutPageCreateOrderError(getErrorMessage(response)));
    }
  }
}
