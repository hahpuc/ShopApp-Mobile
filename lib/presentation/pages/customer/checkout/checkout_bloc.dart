import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_state.dart';
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

  Future<void> checkoutOrder() async {
    emit(CheckOutPageLoadingState());

    // var response = await appRepository.apiService.getProductDetail(productID);

    // if (response.isSuccessful()) {
    //   final resultData = response.response?.data;

    // //   emit(ProductDetailGetDataSuccess(resultData!.data!));
    // } else {
    //   emit(CheckOutPageGetDataErrorState(getErrorMessage(response)));
    // }
  }
}
