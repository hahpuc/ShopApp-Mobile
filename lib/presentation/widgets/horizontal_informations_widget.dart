import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class HorizontalInformations extends StatelessWidget {
  final String? title;
  final String? value;
  final FontWeight? fontWeight;
  const HorizontalInformations({
    this.title,
    this.value,
    this.fontWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title!.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitle(),
          _buildValue(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return CustomText(
      title ?? ' ',
      color: AppColor.colorGrey,
      fontSize: FontSize.MEDIUM,
      fontWeight: this.fontWeight ?? FontWeight.w500,
    );
  }

  Widget _buildValue() {
    return CustomText(
      value ?? ' ',
      color: AppColor.colorPrimary,
      fontSize: FontSize.MEDIUM,
      fontWeight: this.fontWeight ?? FontWeight.w600,
    );
  }
}
