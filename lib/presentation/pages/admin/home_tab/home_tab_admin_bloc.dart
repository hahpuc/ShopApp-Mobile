import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/admin/home_tab/home_tab_admin_state.dart';

class HomeTabAdminPageBloc extends BaseBloc<HomeTabAdminPageState> {
  final AppRepository appRepository;

  HomeTabAdminPageBloc({required this.appRepository})
      : super(HomeTabAdminPageState());

  Future<void> getProductWithCategory(String category) async {
    emit(HomeTabAdminPageLoadingState());
    var response =
        await appRepository.apiService.getProductByCategory(category);
    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(HomeTabAdminPageGetDataSuccessState(resultData?.data));
    } else {
      emit(HomeTabAdminPageGetDataFailState('Failed to get data'));
    }
  }
}
