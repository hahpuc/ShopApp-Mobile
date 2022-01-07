import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/bloc/update_order_state.dart';

class UpdateOrderBloc extends BaseBloc<UpdateOrderState> {
  final AppRepository appRepository;
  UpdateOrderBloc({required this.appRepository}) : super(UpdateOrderState());

  Future<void> updateOrder() async {
    emit(UpdateOrderLoadingState());

    await Future.delayed(Duration(seconds: 1));

    emit(UpdateOrderSuccess());
  }
}
