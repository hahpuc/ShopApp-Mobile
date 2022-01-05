
import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_state.dart';

class HomeTabPageBloc extends BaseBloc<HomeTabPageState> {
  final AppRepository appRepository;

  HomeTabPageBloc({required this.appRepository}) : super(HomeTabPageState());

  Future<void> getProductWithCategory(String category) async {
    emit(HomeTabPageLoadingState());
    var response =
        await appRepository.apiService.getProductByCategory(category);
    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(HomeTabPageGetDataSuccessState(resultData?.data));
    } else {
      emit(HomeTabPageGetDataFailState('Failed to get data'));
    }
  }
}
