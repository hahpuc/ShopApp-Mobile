import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/app_utils.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class BoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image(
              image: Assets.images.imgBackground,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Positioned(
                top: 200,
                left: 25,
                child: CustomText(
                  "MAKE YOUR",
                  fontSize: FontSize.BIG_1,
                  color: AppColor.colorGreyLight,
                )),
            Positioned(
                top: 240,
                left: 25,
                child: CustomText(
                  "HOME BEAUTIFUL",
                  fontSize: FontSize.BIG_2,
                  color: Colors.white,
                )),
            Positioned(
              top: 320,
              left: 25,
              child: CustomText(
                "The best simple place where you\n discover most wonderful furnitures\n and make your home beautiful",
                fontSize: FontSize.BIG,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.horizontalSpacing,
                ),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 32.0,
                  child: Column(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: "GET START",
                          onPressed: () {
                            AppUtils.finishOnboarding();
                            Navigator.of(context).pushNamed(RoutePaths.SIGNIN);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
