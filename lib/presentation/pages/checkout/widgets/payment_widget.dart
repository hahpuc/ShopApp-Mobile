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
    return InkWell(
      onTap: () {
        print('Change Payment');
      },
      child: CardShadowWidget(
        padding: 16.0,
        child: Row(
          children: [
            _buildIconPayment(),
            _buildNamePayment(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconPayment() {
    return Container(
      child: Assets.images.icMomo.image(),
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