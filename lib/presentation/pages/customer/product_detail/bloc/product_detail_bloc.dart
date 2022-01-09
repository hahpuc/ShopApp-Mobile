import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/customer/product_detail/bloc/product_detail_state.dart';

class ProductDetailPageBloc extends BaseBloc<ProductDetailPageState> {
  final AppRepository appRepository;
  ProductDetailPageBloc({required this.appRepository})
      : super(ProductDetailPageState());

  Future<void> getProductDetailsData(String productID) async {
    emit(ProductDetailPageLoadingState());

    var response = await appRepository.apiService.getProductDetail(productID);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(ProductDetailGetDataSuccess(resultData!.data!));
    } else {
      emit(ProductDetailGetDataFailed(getErrorMessage(response)));
    }
  }
}
