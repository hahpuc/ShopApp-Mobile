import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/forgot_password/forgot_password_form.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 65.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: AppDimen.spacing_3),
              child: Text(
                "Forgot Password",
                style: TextStyle(fontSize: FontSize.BIG_2),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
