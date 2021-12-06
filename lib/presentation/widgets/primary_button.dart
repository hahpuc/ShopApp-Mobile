import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'base/custom_button.dart';

typedef OnPressed();

class PrimaryButton extends StatelessWidget {
  final String title;
  final OnPressed? onPressed;
  final Widget? imageRight;
  final bool? primaryStyle;
  final Color? primaryColor;
  final double borderWidth;
  final double borderOpacity;
  final Color textColor;

  const PrimaryButton({
    Key? key,
    this.title = "OK",
    this.imageRight,
    this.onPressed,
    this.primaryStyle = true,
    this.primaryColor = AppColor.colorPrimary,
    this.borderWidth = 0.0,
    this.borderOpacity = 0.3,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.colorPrimary.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: CustomButton(
        title,
        padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
        fontSize: FontSize.BIG,
        borderRadius: AppDimen.radiusNormal,
        sizeStyle: CustomBottomSizeStyle.MATCH_PARENT,
        rightIcon: imageRight,
        backgroundColor: primaryColor!,
        borderWidth: borderWidth,
        borderOpacity: borderOpacity,
        textColor: textColor,
        onTap: onPressed,
      ),
    );
  }
}
