import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/forgot_password/forgot_password_form.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/base/tap_outside_to_unfocus.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return TapOutsideToUnfocus(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: FooterScrollView(
          body: _buildBody(),
          footer: Container(),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar();
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}
