import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/customer/shipping_addresses/bloc/shipping_addresses_state.dart';
import 'package:furniture_shop/values/app_utils.dart';

class ShippingAddressPageBloc extends BaseBloc<ShippingAddressPageState> {
  final AppRepository appRepository;
  ShippingAddressPageBloc({required this.appRepository})
      : super(ShippingAddressPageState());

  Future<void> getUserAddress() async {
    emit(ShippingAddressPageLoadingState());

    var response = await appRepository.apiService.getUserAddress();

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(ShippingAddressPageGetDataSuccessState(resultData!.data!));
    } else {
      emit(ShippingAddressPageGetDataErrorState(getErrorMessage(response)));
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    emit(ShippingAddressPageLoadingState());

    var response = await appRepository.apiService.setDefaultAddress(addressId);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      if (resultData?.code == 200) {
        emit(SetAddressDefaultSuccessState());
      } else {
        emit(SetAddressDefaultErrorState(getErrorMessage(response)));
      }
    }
  }

  void setDefaultAddressToLocal(ShippingAddressModel? address) async {
    emit(ShippingAddressPageLoadingState());

    await Future.delayed(Duration(seconds: 1));

    AppUtils.setDefaultAddress(address!);

    print("---> ${AppUtils.getDefaultAddress().toJson()}");

    emit(SetAddressToLocalSuccessState());
  }
}
