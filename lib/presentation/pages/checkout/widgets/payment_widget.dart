import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/checkout/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/font_sizes.dart';
import '/values/dimens.dart';

class PaymentWidget extends StatelessWidget {
  final String? namePayment;

  const PaymentWidget({
    this.namePayment = 'Momo',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardShadowWidget(
      margin: const EdgeInsets.symmetric(vertical: AppDimen.verticalSpacing),
      child: Row(
        children: [
          _buildIconPayment(),
          _buildNamePayment(),
        ],
      ),
    );
  }

  Widget _buildIconPayment() {
    return Container(
      child: Assets.images.card.image(),
    );
  }

  Widget _buildNamePayment() {
    return CustomText(
      namePayment!,
      fontSize: FontSize.SMALL,
      fontWeight: FontWeight.w600,
    );
  }
}
