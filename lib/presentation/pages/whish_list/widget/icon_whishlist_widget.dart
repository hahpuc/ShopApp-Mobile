import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';

class IconWhishList extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final Function()? onTap;

  const IconWhishList({
    this.icon,
    this.color = AppColor.colorPrimary,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: AppDimen.icon_size,
        color: color,
      ),
    );
  }
}
