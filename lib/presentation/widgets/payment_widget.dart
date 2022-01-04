import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';
import '/values/dimens.dart';

class PaymentWidget extends StatelessWidget {
  final String? namePayment;
  final Image? icon;
  final VoidCallback? onTap;

  const PaymentWidget({
    Key? key,
    this.namePayment,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CardShadowWidget(
        padding: 16.0,
        child: Row(
          children: [
            _buildIconPayment(),
            SizedBox(width: AppDimen.horizontalSpacing),
            _buildNamePayment(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconPayment() {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: AppDimen.spacing_1, horizontal: AppDimen.spacing_2),
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
          boxShadow: [
            BoxShadow(
              color: AppColor.colorBlack.withOpacity(0.08),
              blurRadius: 25,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Container(
          height: 24.0,
          width: 24.0,
          child: icon,
        ));
  }

  Widget _buildNamePayment() {
    return CustomText(
      namePayment!,
      fontSize: FontSize.SMALL,
      fontWeight: FontWeight.w600,
    );
  }
}
