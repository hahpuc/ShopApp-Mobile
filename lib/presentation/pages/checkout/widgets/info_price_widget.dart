import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class InfoPriceWidget extends StatelessWidget {
  final String? title;
  final double? price;
  final FontWeight? fontWeight;
  final bool? discount;
  const InfoPriceWidget({
    this.title = '',
    this.price = 0.0,
    this.fontWeight = FontWeight.w600,
    this.discount = false,
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
          _buildPrice(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return CustomText(
      '${title!}: ',
      color: AppColor.colorGrey,
      fontSize: FontSize.BIG,
    );
  }

  Widget _buildPrice() {
    return RichText(
      text: TextSpan(
        text: discount!
            ? '-${price!.toStringAsFixed(2)}'
            : '${price!.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: FontSize.BIG,
          color: AppColor.colorPrimary,
          fontWeight: fontWeight!,
        ),
        children: [
          TextSpan(
            text: ' \$',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
