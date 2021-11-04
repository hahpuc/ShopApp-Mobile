import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/profile/profile_state.dart';

class ProfilePageBloc extends BlocBase<ProfilePageState> {
  final AppRepository appRepository;

  ProfilePageBloc({required this.appRepository}) : super(ProfilePageState());

  Future<void> getCategoriesData() async {
    emit(ProfilePageLoadingState());

    UserResponseData user = UserResponseData(
        userId: 1, name: "Nancy Momoland", phoneNumber: "0969696969");
    if (user != null) {
      emit(ProfilePageGetDataSuccessState(user));
    } else
      emit(ProfilePageGetDataFailState());
  }
}
