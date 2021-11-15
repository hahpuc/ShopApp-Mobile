import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/form_error.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/dimens.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? email;
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
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 32.0,
            child: Column(
              children: [
                Expanded(
                  child: PrimaryButton(
                    title: "CONTINUE",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
