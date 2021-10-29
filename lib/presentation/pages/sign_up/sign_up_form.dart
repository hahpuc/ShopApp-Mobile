import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/presentation/pages/boarding/dock_button.dart';
import 'package:furniture_shop/presentation/pages/sign_in/form_error.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
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
          InkWell(
            child: DockButton(name: "SIGN UP"),
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
                "Already have an account? ",
                style: TextStyle(fontSize: FontSize.SMALL),
              ),
              GestureDetector(
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: FontSize.SMALL, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.SIGNIN);
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.isNotEmpty && password == conform_password) {
          removeError(error: AppConstants.kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPassNullError);
        } else if ((password != value)) {
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
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: AppConstants.kShortPassError);
        }
        password = value;
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
        //hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
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
        //hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
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
        //hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
