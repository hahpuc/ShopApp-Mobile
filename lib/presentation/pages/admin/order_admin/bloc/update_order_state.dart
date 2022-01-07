import 'package:furniture_shop/bloc/base/base_state.dart';

class UpdateOrderState extends BaseState {}

class UpdateOrderLoadingState extends UpdateOrderState {}

class UpdateOrderSuccess extends UpdateOrderState {}

class UpdateOrderFailed extends UpdateOrderState {}
