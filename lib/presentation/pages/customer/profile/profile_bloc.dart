import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/customer/profile/profile_state.dart';

class ProfilePageBloc extends BlocBase<ProfilePageState> {
  final AppRepository appRepository;

  ProfilePageBloc({required this.appRepository}) : super(ProfilePageState());

  Future<void> getCategoriesData() async {
    emit(ProfilePageLoadingState());

    UserModel user = UserModel(
        userId: "1", name: "Nancy Momoland", phoneNumber: "0969696969");
    if (user != null) {
      emit(ProfilePageGetDataSuccessState(user));
    } else
      emit(ProfilePageGetDataFailState());
  }

  void logout() async {
    emit(ProfilePageLoadingState());
    appRepository.prefRepository.clearUserSession();
    emit(LogoutSuccessState());
  }
}
