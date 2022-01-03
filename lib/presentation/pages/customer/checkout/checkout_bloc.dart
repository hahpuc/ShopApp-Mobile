import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_state.dart';

class CheckOutPageBloc extends BaseBloc<CheckOutPageState> {
  final AppRepository appRepository;
  CheckOutPageBloc({required this.appRepository}) : super(CheckOutPageState());

  Future<void> checkoutOrder() async {
    emit(CheckOutPageLoadingState());

    // var response = await appRepository.apiService.getProductDetail(productID);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      //   emit(ProductDetailGetDataSuccess(resultData!.data!));
    } else {
      emit(CheckOutPageGetDataErrorState(getErrorMessage(response)));
    }
  }
}
