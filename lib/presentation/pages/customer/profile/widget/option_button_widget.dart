import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class OptionButton extends StatelessWidget {
  final String? option;
  final String? detail;
  final Function()? onPress;
  OptionButton({Key? key, this.option, this.detail, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
      padding: EdgeInsets.symmetric(
          horizontal: AppDimen.spacing_3, vertical: AppDimen.spacing_3),
      child: InkWell(
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  option ?? "",
                  fontSize: FontSize.BIG,
                  fontWeight: FontWeight.bold,
                  color: AppColor.colorPrimary,
                ),
                CustomText(
                  detail ?? "",
                  fontSize: FontSize.SMALL_1,
                  color: AppColor.colorTextLight,
                )
              ],
            ),
            SvgPicture.asset(Assets.images.icNavigation.path)
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.colorWhite,
        boxShadow: [
          BoxShadow(
            color: AppColor.colorBoxShadowProfile.withOpacity(0.2),
            blurRadius: 40,
            offset: Offset(0, 7), // Shadow position
          ),
        ],
      ),
    );
  }
}
