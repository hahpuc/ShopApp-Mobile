import 'package:furniture_shop/bloc/base/base_state.dart';

class EditProductState extends BaseState {}

class EditProductLoadingState extends EditProductState {}

class EditProductGetDataSuccess extends EditProductState {}

class EditProductGetDataFailed extends EditProductState {}

class UpdateProductSuccessState extends EditProductState {}
