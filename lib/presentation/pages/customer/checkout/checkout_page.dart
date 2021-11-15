import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/horizontal_informations_widget.dart';
import 'package:furniture_shop/presentation/widgets/payment_widget.dart';
import 'package:furniture_shop/presentation/widgets/shipping_information_widget.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        'Check out',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
        color: AppColor.colorPrimary,
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: AppDimen.horizontalSpacing,
          right: AppDimen.horizontalSpacing,
          bottom: AppDimen.spacing_3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailList(),
            _buildFooterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('Shipping Address'),
        _buildDetailShippingAddress(),
        _buildTitle('Payment'),
        __buildDetailPayment(),
      ],
    );
  }

  Widget _buildFooterInfo() {
    return Column(
      children: [
        _buildInfoPrice(),
        _buildButton(),
      ],
    );
  }

  Widget _buildTitle(String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
      child: CustomText(
        title!,
        color: AppColor.colorGrey,
        fontSize: FontSize.BIG,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDetailShippingAddress() {
    return ShippingInformation(
      name: 'Long Nguyen',
      phoneNumber: '(+84) 123456789',
      address: '123 Nguyen Van Linh, District 1, Ho Chi Minh City',
    );
  }

  Widget __buildDetailPayment() {
    return PaymentWidget(
      namePayment: AppPayment.zalo,
      icon: Assets.images.icZalo.image(),
    );
  }

  Widget _buildInfoPrice() {
    return CardShadowWidget(
      padding: AppDimen.verticalSpacing,
      margin: const EdgeInsets.symmetric(vertical: AppDimen.verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontalInformations(
            title: 'Order',
            value: '70.00 \$',
          ),
          HorizontalInformations(
            title: 'Delivery',
            value: '15.00 \$',
          ),
          HorizontalInformations(
            title: 'Discount',
            value: '-20.00 \$',
          ),
          HorizontalInformations(
            title: 'Total',
            value: '65.00 \$',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return CustomButton(
      'Submit order',
      padding: EdgeInsets.all(AppDimen.spacing_2),
      sizeStyle: CustomBottomSizeStyle.MATCH_PARENT,
      fontSize: FontSize.BIG,
    );
  }
}
