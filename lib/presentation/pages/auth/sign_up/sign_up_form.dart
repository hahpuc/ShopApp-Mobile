import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/form_error.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_up/bloc/sign_up_state.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conformPassword = TextEditingController();
  bool _passwordVisible = false;
  bool _conformPasswordVisible = false;
  final List<String?> errors = [];

  SignUpPageBloc _bloc = SignUpPageBloc(appRepository: locator.get());

  _blocListener(BuildContext context, SignUpPageState state) async {
    print("State $state");
    if (state is SignUpPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is SignUpDataFailed) {
      state.msg = "User already exist";
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

  @override
  Widget build(BuildContext context) {
    final horizonPadding = AppDimen.spacing_3;
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<SignUpPageBloc, SignUpPageState>(
        listener: _blocListener,
        child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is SignUpDataSuccess) {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushNamed(context, RoutePaths.SIGNIN);
              });
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                      child: buildNameFormField()),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                      child: buildEmailFormField()),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                      child: buildPhoneNumberFormField()),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                      child: buildPasswordFormField()),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                    child: buildConformPassFormField(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizonPadding),
                      child: FormError(errors: errors)),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 32.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            title: "SIGN UP",
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  errors.isEmpty) {
                                _formKey.currentState!.save();
                                final user = UserModel(
                                    email: this.email.text,
                                    name: this.name.text,
                                    password: this.password.text,
                                    phoneNumber: this.phoneNumber.text);
                                print(user);
                                _bloc.postUserSignUpData(user);
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
                          text: "Already have an account? ",
                          style: TextStyle(
                              fontSize: FontSize.SMALL,
                              color: AppColor.colorTextLight),
                        ),
                        TextSpan(
                          text: "SIGN IN",
                          style: TextStyle(
                              fontSize: FontSize.SMALL,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {Navigator.pop(context)},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      controller: this.conformPassword,
      obscureText: !_conformPasswordVisible,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.isNotEmpty && password == conformPassword) {
          removeError(error: AppConstants.kMatchPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPassNullError);
        } else if ((this.password.text != value)) {
          addError(error: AppConstants.kMatchPassError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        //hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.remove_red_eye_outlined,
          ),
          onTap: () {
            setState(() {
              _conformPasswordVisible = !_conformPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: this.password,
      obscureText: !_passwordVisible,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: AppConstants.kShortPassError);
        }
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
      controller: this.email,
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

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: this.name,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kNamelNullError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: this.phoneNumber,
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPhoneNumberNullError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
