import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/checkout/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ShippingAddressWidget extends StatelessWidget {
  final String? name;
  final String? phoneNumber;
  final String? address;

  const ShippingAddressWidget({
    this.name = 'Long Nguyen',
    this.phoneNumber = '(+84) 123456789',
    this.address = 'Nha xx, Duong xx, Quan XX, Tp XXX, Tỉnh XX',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardShadowWidget(
      margin: const EdgeInsets.symmetric(vertical: AppDimen.verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildDetailInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimen.verticalSpacing),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorGreyLight,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            name!,
            fontSize: FontSize.BIG,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
          _buildButtonIcon(),
        ],
      ),
    );
  }

  Widget _buildButtonIcon() {
    return InkWell(
      onTap: () {},
      child: SvgPicture.asset(
        Assets.images.icEditSvg.path,
        height: 24.0,
        width: 24.0,
      ),
    );
  }

  Widget _buildDetailInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppDimen.verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextInfo(phoneNumber),
          const SizedBox(height: 5.0),
          _buildTextInfo(address),
        ],
      ),
    );
  }

  Widget _buildTextInfo(String? text) {
    return CustomText(
      text!,
      fontSize: FontSize.SMALL,
      color: AppColor.colorTextLight,
    );
  }
}
