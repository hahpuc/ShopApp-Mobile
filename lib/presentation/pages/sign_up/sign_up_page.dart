import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/sign_up/sign_up_form.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppDimen.verticalSpacing),
            SizedBox(
              height: 65.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Divider(
                      color: Colors.black,
                      height: 1,
                      thickness: 1,
                    ),
                    Container(
                      //child: Image,
                      color: Colors.grey[50],
                      height: 65.0,
                      width: 100,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: AppDimen.spacing_3),
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: FontSize.BIG_2),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
