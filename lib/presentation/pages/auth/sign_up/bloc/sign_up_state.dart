import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';

class SignUpPageState extends BaseState {}

class SignUpPageLoadingState extends SignUpPageState {}

class SignUpDataSuccess extends SignUpPageState {
  final UserModel data;

  SignUpDataSuccess(this.data);
}

class SignUpDataFailed extends SignUpPageState {
  String msg;

  SignUpDataFailed(this.msg);
}
