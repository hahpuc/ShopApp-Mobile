import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/customer/order/bloc/order_state.dart';

class OrderPageBloc extends BaseBloc<OrderPageState> {
  final AppRepository appRepository;
  OrderPageBloc({required this.appRepository}) : super(OrderPageState());

  Future<void> getAllOrders() async {
    emit(OrderPageLoadingState());

    var response = await appRepository.apiService.getAllOrder();

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(OrderPageSuccessState(resultData!.data!));
    } else {
      emit(OrderPageFailedState(getErrorMessage(response)));
    }
  }

  Future<void> getOrderByStatus(int status) async {
    emit(OrderPageLoadingState());

    var response = await appRepository.apiService.getOrderByStatus(status);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(OrderPageSuccessState(resultData!.data!));
    } else {
      emit(OrderPageFailedState(getErrorMessage(response)));
    }
  }
}
