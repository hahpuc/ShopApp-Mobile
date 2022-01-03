import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/presentation/pages/customer/cart/bloc/my_cart_page_state.dart';

class MyCartPageBloc extends BaseBloc<MyCartPageState> {
  final AppRepository appRepository;
  MyCartPageBloc({required this.appRepository}) : super(MyCartPageState());

  Future<void> getMyCart() async {
    emit(MyCartPageLoadingState());
    await Future.delayed(Duration(seconds: 1));

    var response = await appRepository.apiService.getUserCart();

    if (response.isSuccessful()) {
      final resultData = response.response?.data;
      emit(MyCartPageGetDataSuccessState(resultData!.data!));
    } else {
      emit(MyCardPageGetDataFailedState(getErrorMessage(response)));
    }
  }

  Future<void> deleteProductInCart(ProductDetailModel product) async {
    emit(MyCartPageLoadingState());
    await Future.delayed(Duration(seconds: 1));

    var response =
        await appRepository.apiService.postDeleteProductInCart(product);

    if (response.isSuccessful()) {
      emit(MyCartDeleteItemSuccessState('Product delete successfully'));
    } else {
      emit(MyCartDeleteItemFailedState(getErrorMessage(response)));
    }
  }
}
