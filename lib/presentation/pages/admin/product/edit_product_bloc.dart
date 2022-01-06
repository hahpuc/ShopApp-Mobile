import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/admin/product/edit_product_state.dart';

class EditProductBloc extends BaseBloc<EditProductState> {
  final AppRepository appRepository;
  EditProductBloc({required this.appRepository}) : super(EditProductState());

  Future<void> getProductDetailsData() async {
    emit(EditProductLoadingState());
    await Future.delayed(Duration(seconds: 1));

    emit(EditProductGetDataSuccess());
  }

  Future<void> updateProduct() async {
    emit(EditProductLoadingState());
    await Future.delayed(Duration(seconds: 1));

    emit(UpdateProductSuccessState());
  }
}
