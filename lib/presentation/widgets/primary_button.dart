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

  const PrimaryButton({
    Key? key,
    this.title = "OK",
    this.imageRight,
    this.onPressed,
    this.primaryStyle = true,
    this.primaryColor = AppColor.colorPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50.0),
      child: CustomButton(
        title,
        padding: EdgeInsets.all(16),
        fontSize: FontSize.BIG,
        borderRadius: AppDimen.radiusNormal,
        sizeStyle: CustomBottomSizeStyle.MATCH_PARENT,
        rightIcon: imageRight,
        onTap: onPressed,
      ),
    );
  }
}
