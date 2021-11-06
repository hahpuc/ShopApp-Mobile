import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/presentation/pages/sign_in/form_error.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? email;
  TextEditingController? password;
  bool _passwordVisible = false;
  final List<String?> errors = [];

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: buildEmailFormField()),
          SizedBox(
            height: 16.0,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
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
                    Navigator.pushNamed(context, RoutePaths.FORGOTPASSWORD);
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
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
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
                      Navigator.pushNamed(context, RoutePaths.HOME);

                      //   if (_formKey.currentState!.validate()) {
                      //     _formKey.currentState!.save();
                      //     // if all are valid then go to success screen
                      //     //KeyboardUtil.hideKeyboard(context);
                      //     //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                      //   }
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
                      fontSize: FontSize.SMALL, color: AppColor.colorTextLight),
                ),
                TextSpan(
                  text: "SIGN UP",
                  style: TextStyle(
                      fontSize: FontSize.SMALL, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => {Navigator.pushNamed(context, RoutePaths.SIGNUP)},
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
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
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
