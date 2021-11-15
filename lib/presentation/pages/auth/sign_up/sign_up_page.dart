import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_up/sign_up_form.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/base/tap_outside_to_unfocus.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                  child: SvgPicture.asset(Assets.images.icFurniture.path),
                  color: Colors.white,
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
          child: CustomText(
            "Welcome",
            fontSize: FontSize.BIG_2,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SignUpForm(),
      ],
    );
  }
}
