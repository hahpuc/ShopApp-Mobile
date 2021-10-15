import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/presentation/pages/demo/demo_state.dart';
import 'package:furniture_shop/utils/ext_utils.dart';

class DemoBloc extends BaseBloc<DemoState> {
  final AppRepository appRepository;
  DemoBloc({required this.appRepository}) : super(DemoState());

  int _count = 0;

  void increaseValue() {
    _count = _count + 1;
    emit(DemoIntState(value: _count));
  }

  void getValue() {
    emit(DemoIntState(value: _count));
  }

  Future<void> requestNetwork() async {
    emit(DemoLoadingState());
    var result = await appRepository.apiService.getDemo();
    if (result.isSuccessful()) {
      emit(DemoNetworkState(data: result.response!.toMap().toString()));
    } else {
      emit(DemoNetworkState(data: result.exception!.apiErrorMessage()));
    }
  }
}
