import 'package:flutter/material.dart';
import '/values/colors.dart';
import '/values/dimens.dart';

class CardShadowWidget extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? margin;
  final double? padding;
  final double? borderRadius;
  final Color? backgroundColor;

  const CardShadowWidget({
    this.child,
    this.margin = const EdgeInsets.all(0),
    this.padding = 0,
    this.borderRadius = AppDimen.radiusNormal,
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin!,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 10,
            color: AppColor.colorPrimary.withOpacity(.15),
          ),
        ],
      ),
      child: child,
    );
  }
}
