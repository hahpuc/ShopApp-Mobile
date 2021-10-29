import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/presentation/pages/boarding/dock_button.dart';
import 'package:furniture_shop/presentation/pages/sign_in/form_error.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
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
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: FormError(errors: errors)),
          SizedBox(
            height: 170,
          ),
          InkWell(
            child: DockButton(name: "CONTINUE"),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                //KeyboardUtil.hideKeyboard(context);
                //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: FontSize.SMALL),
              ),
              GestureDetector(
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: FontSize.SMALL, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.SIGNUP);
                },
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
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
        //hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
