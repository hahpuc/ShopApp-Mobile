import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'base/custom_text.dart';
import 'card_shadow_widget.dart';

class ShippingInformation extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;
  const ShippingInformation({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardShadowWidget(
      padding: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimen.spacing_2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  name,
                  fontSize: FontSize.BIG,
                  fontWeight: FontWeight.bold,
                ),
                SvgPicture.asset(
                  Assets.images.icEditSvg.path,
                  height: 24.0,
                  width: 24.0,
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: AppColor.indicator),
          SizedBox(height: AppDimen.verticalSpacing),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(phoneNumber, color: AppColor.colorTextLight),
                SizedBox(height: AppDimen.spacing_1),
                CustomText(address, color: AppColor.colorTextLight)
              ],
            ),
          ),
          SizedBox(height: AppDimen.verticalSpacing),
        ],
      ),
    );
  }
}
