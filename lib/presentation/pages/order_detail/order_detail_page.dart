import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/checkout/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/pages/checkout/widgets/info_price_widget.dart';
import 'package:furniture_shop/presentation/pages/checkout/widgets/payment_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
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
          title: 'Add to cart',
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
      Divider(color: AppColor.indicator, height: 1.0),
      SizedBox(height: AppDimen.verticalSpacing),
      TimeLiveView(),
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
      CardShadowWidget(
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
                    'Long Nguyen',
                    fontSize: FontSize.BIG,
                    fontWeight: FontWeight.bold,
                  ),
                  SvgPicture.asset(
                    Assets.images.icEdit.path,
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
                  CustomText('(+84) 123456789', color: AppColor.colorTextLight),
                  SizedBox(height: AppDimen.spacing_1),
                  CustomText('Nha xx, Duong xx, Quan XX, Tp XXX, Tỉnh XX',
                      color: AppColor.colorTextLight)
                ],
              ),
            ),
            SizedBox(height: AppDimen.verticalSpacing),
          ],
        ),
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
        child: PaymentWidget(),
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
            InfoPriceWidget(title: 'Order ID', price: 70),
            InfoPriceWidget(title: 'Order Time', price: 15),
            InfoPriceWidget(title: 'Payment Time', price: 15),
            InfoPriceWidget(
              title: 'Ship time',
              price: 20,
              discount: true,
            ),
            InfoPriceWidget(
              title: 'Completed time',
              price: 20,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      )
    ];
  }
}
