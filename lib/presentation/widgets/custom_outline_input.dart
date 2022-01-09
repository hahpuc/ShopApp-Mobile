import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'base/custom_text.dart';

class CustomOutlineInput extends StatelessWidget {
  final String? title;
  final EdgeInsets margin;
  final Widget? child;
  final Color backgroundColor;

  const CustomOutlineInput({
    this.title = '',
    this.margin = const EdgeInsets.all(0),
    this.child,
    this.backgroundColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: AppDimen.spacing_1,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.colorGreyLight,
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title!.isNotEmpty
              ? CustomText(
                  title!,
                  fontSize: FontSize.SMALL_1,
                  color: AppColor.colorGrey,
                )
              : const SizedBox.shrink(),
          child!,
        ],
      ),
    );
  }
}
