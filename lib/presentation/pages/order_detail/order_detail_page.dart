import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/horizontal_informations_widget.dart';
import 'package:furniture_shop/presentation/widgets/payment_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/presentation/widgets/shipping_information_widget.dart';
import 'package:furniture_shop/presentation/widgets/time_line_view.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPageState createState() => new _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: CustomText(
          'Order Detail',
          fontFamily: FontFamily.gelasio,
          fontSize: FontSize.BIG,
        ),
        leading: AppBackButton(imgColor: Colors.black),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FooterScrollView(
      body: _buildContent(),
      footer: _buildFooter(),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50.0,
        child: PrimaryButton(
          imageRight: SvgPicture.asset(
            Assets.images.icChat.path,
          ),
          title: 'Contact Seller',
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildShippingInformation(),
          ..._buildDeliveryAddress(),
          ..._buildListItem(),
          ..._buildPaymentInfo(),
          ..._buildInfoPrice(),
        ],
      ),
    );
  }

  List<Widget> _buildShippingInformation() {
    return [
      Row(
        children: [
          SvgPicture.asset(
            Assets.images.icDelivery.path,
            height: 32.0,
            width: 32.0,
          ),
          SizedBox(width: AppDimen.horizontalSpacing),
          CustomText('Shipping information')
        ],
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      TimeLiveView(),
      SizedBox(height: AppDimen.verticalSpacing),
      Divider(color: AppColor.indicator, height: 1.0),
      SizedBox(height: AppDimen.verticalSpacing),
    ];
  }

  List<Widget> _buildDeliveryAddress() {
    return [
      Row(
        children: [
          Icon(
            Icons.location_on,
            size: 32.0,
          ),
          SizedBox(width: AppDimen.horizontalSpacing),
          CustomText('Delivery address'),
        ],
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      ShippingInformation(
        name: 'Long Nguyen',
        phoneNumber: '(+84) 123456789',
        address: '123 Nguyen Van Linh, District 1, Ho Chi Minh City',
      ),
    ];
  }

  List<Widget> _buildListItem() {
    return [
      SizedBox(height: AppDimen.verticalSpacing),

      for (int i = 0; i < 2; ++i) ..._buildItem(),
      SizedBox(height: AppDimen.verticalSpacing),

      // Total price
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText('Order total', fontWeight: FontWeight.w600),
          CustomText('\$100.00', fontWeight: FontWeight.w700),
        ],
      )
    ];
  }

  List<Widget> _buildItem() {
    return [
      SizedBox(height: AppDimen.verticalSpacing),
      Container(
        height: 100.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: AppDimen.horizontalSpacing),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Gaming Table',
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    '\$' + '50.00',
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      Divider(
        color: AppColor.colorGreyLight,
        height: 1.0,
      )
    ];
  }

  List<Widget> _buildPaymentInfo() {
    return [
      SizedBox(height: AppDimen.verticalSpacing),
      CustomText('Payment',
          fontSize: FontSize.BIG, fontWeight: FontWeight.bold),
      SizedBox(height: AppDimen.verticalSpacing),
      Container(
        height: 75.0,
        child: PaymentWidget(
          namePayment: AppPayment.momo,
          icon: Assets.images.icMomo.image(),
        ),
      ),
    ];
  }

  List<Widget> _buildInfoPrice() {
    return [
      SizedBox(height: AppDimen.verticalSpacing),
      CardShadowWidget(
        padding: AppDimen.verticalSpacing,
        margin: const EdgeInsets.symmetric(vertical: AppDimen.verticalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalInformations(
              title: 'Order ID',
              value: '210909T28121W6XD',
              fontWeight: FontWeight.bold,
            ),
            HorizontalInformations(
              title: 'Order Time',
              value: '09-09-2021 21:09',
            ),
            HorizontalInformations(
              title: 'Payment Time',
              value: '09-09-2021 21:15',
            ),
            HorizontalInformations(
              title: 'Shipping Time',
              value: '11-09-2021 09:05',
            ),
            HorizontalInformations(
              title: 'Completed time',
              value: '22-09-2021 11:03',
            ),
          ],
        ),
      )
    ];
  }
}
