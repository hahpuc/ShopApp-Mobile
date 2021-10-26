import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/sign_in/sign_form.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimen.horizontalSpacing,
            vertical: AppDimen.verticalSpacing),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 65.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppDimen.spacing_3 - AppDimen.horizontalSpacing),
                child: Text(
                  "Hello !",
                  style: TextStyle(
                      fontSize: FontSize.BIG_1,
                      color: Colors.black.withOpacity(0.5)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppDimen.spacing_3 - AppDimen.horizontalSpacing),
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: FontSize.BIG_2),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SignForm(),
            ],
          ),
        ),
      ),
    ));
  }
}
