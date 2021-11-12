import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/shipping_addresses/address.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ShippingAddressesPage extends StatelessWidget {
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
        'Shipping Addresses',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
    );
  }

  Widget _buildBody() {
    return FooterScrollView(
      body: _buildListAddresses(),
      footer: _buildFooter(),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50.0,
        child: PrimaryButton(
          title: 'Save Address',
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildListAddresses() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: mockAddress,
      ),
    );
  }

  List<Address> mockAddress = [
    Address(
        name: "Đầu cắt moi",
        phoneNumber: "09099909009",
        address: "Khu 2, Hoàng Cương, Thanh Ba, Phú Thọ.",
        isDefaultAddress: true),
    Address(
        name: "Ngô Bá Khá",
        phoneNumber: "09099909009",
        address: "Khu 2, Hoàng Cương, Thanh Ba, Phú Thọ.",
        isDefaultAddress: false),
    Address(
        name: "Phúc XO",
        phoneNumber: "09099909009",
        address: "Khu 2, Hoàng Cương, Thanh Ba, Phú Thọ.",
        isDefaultAddress: false),
    Address(
        name: "Bomman",
        phoneNumber: "09099909009",
        address: "Khu 2, Hoàng Cương, Thanh Ba, Phú Thọ.",
        isDefaultAddress: false),
  ];
}