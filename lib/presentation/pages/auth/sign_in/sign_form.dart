import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/local/pref_repository.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/form_error.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/sign_in_state.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _passwordVisible = false;
  final List<String?> errors = [];

  SignInPageBloc _bloc = SignInPageBloc(appRepository: locator.get());

  _blocListener(BuildContext context, SignInPageState state) async {
    print("State $state");
    if (state is SignInPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is SignInFailed) {
      state.msg = "User doesn't exist";
      EasyLoading.showError(state.msg);
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _saveToken(String accessToken, String refreshToken) async {
    final _preferences = await SharedPreferences.getInstance();
    final repo = PrefRepository(_preferences);
    repo.setAccessToken(accessToken);
    repo.setRefreshToken(refreshToken);
  }

  @override
  Widget build(BuildContext context) {
    final horizonPadding = AppDimen.spacing_3;
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<SignInPageBloc, SignInPageState>(
        listener: _blocListener,
        child: BlocBuilder<SignInPageBloc, SignInPageState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SignInSuccess) {
                print(state.accessToken);
                print(state.refreshToken);
                _saveToken(state.accessToken, state.refreshToken);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, RoutePaths.HOME);
                  _showToast(context);
                });
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizonPadding),
                        child: buildEmailFormField()),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizonPadding),
                        child: buildPasswordFormField()),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.FORGOTPASSWORD);
                            },
                            child: CustomText(
                              "Forgot Password ?",
                              fontSize: FontSize.SMALL,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizonPadding),
                        child: FormError(errors: errors)),
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 32.0,
                      child: Column(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              title: "SIGN IN",
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    errors.isEmpty) {
                                  _formKey.currentState!.save();
                                  final user = UserModel(
                                      email: email.text,
                                      password: password.text);
                                  // if all are valid then go to success screen
                                  _bloc.postUserSignInData(user);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                fontSize: FontSize.SMALL,
                                color: AppColor.colorTextLight),
                          ),
                          TextSpan(
                            text: "SIGN UP",
                            style: TextStyle(
                                fontSize: FontSize.SMALL,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigator.pushNamed(
                                        context, RoutePaths.SIGNUP)
                                  },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('Sign in success'),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: password,
      obscureText: !_passwordVisible,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: AppConstants.kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPassNullError);
        } else if (value.length < 8) {
          addError(error: AppConstants.kShortPassError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.remove_red_eye_outlined,
          ),
          onTap: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kEmailNullError);
        }
        if (AppConstants.emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppConstants.kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kEmailNullError);
        } else if (!AppConstants.emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppConstants.kInvalidEmailError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
