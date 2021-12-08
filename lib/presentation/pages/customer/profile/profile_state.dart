import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';

class ProfilePageState extends BaseState {}

class ProfilePageLoadingState extends ProfilePageState {}

class ProfilePageGetDataSuccessState extends ProfilePageState {
  final UserModel data;
  ProfilePageGetDataSuccessState(this.data);
}

class ProfilePageGetDataFailState extends ProfilePageState {}
