import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/bloc/sign_in_state.dart';

class SignInPageBloc extends BaseBloc<SignInPageState> {
  final AppRepository appRepository;
  SignInPageBloc({required this.appRepository}) : super(SignInPageState());

  Future<void> postUserSignInData(UserModel user) async {
    emit(SignInPageLoadingState());

    var response = await appRepository.apiService.postUserSignIn(user);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;
      final accessToken = response.response?.data!.accessToken;
      final refreshToken = response.response?.data!.refreshToken;

      emit(SignInSuccess(resultData!.data!, accessToken!, refreshToken!));
    } else {
      emit(SignInFailed(getErrorMessage(response)));
    }
  }
}
