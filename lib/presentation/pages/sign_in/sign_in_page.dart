import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/sign_in/sign_form.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/tap_outside_to_unfocus.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TapOutsideToUnfocus(
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
                        child: SvgPicture.asset(
                            $AssetsImagesGen().icFurniture.path),
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
                child: CustomText(
                  "Hello !",
                  fontSize: FontSize.BIG_1,
                  color: AppColor.colorTextLight,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AppDimen.spacing_3),
                child: CustomText(
                  "Welcome Back",
                  fontSize: FontSize.BIG_2,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SignForm(),
            ],
          ),
        ),
      ),
    );
  }
}
