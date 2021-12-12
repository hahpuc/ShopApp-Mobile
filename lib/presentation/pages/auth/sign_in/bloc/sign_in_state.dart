import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';

class SignInPageState extends BaseState {}

class SignInPageLoadingState extends SignInPageState {}

class SignInSuccess extends SignInPageState {
  final UserModel data;
  String accessToken;
  String refreshToken;

  SignInSuccess(this.data, this.accessToken, this.refreshToken);
}

class SignInFailed extends SignInPageState {
  final String msg;

  SignInFailed(this.msg);
}
