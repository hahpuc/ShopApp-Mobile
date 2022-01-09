import 'package:furniture_shop/bloc/base/base_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_up/bloc/sign_up_state.dart';

class SignUpPageBloc extends BaseBloc<SignUpPageState> {
  final AppRepository appRepository;
  SignUpPageBloc({required this.appRepository}) : super(SignUpPageState());

  Future<void> postUserSignUpData(UserModel user) async {
    emit(SignUpPageLoadingState());

    var response = await appRepository.apiService.postUserSignUp(user);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(SignUpDataSuccess(resultData!.data!));
    } else {
      emit(SignUpDataFailed(getErrorMessage(response)));
    }
  }
}
