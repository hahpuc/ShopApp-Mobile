import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/shipping_addresses/address.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ShippingAddressesPage extends StatefulWidget {
  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  bool isDefault = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: CustomText(
        'Shipping Addresses',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
          onPressed: () {
            _addShippingAddressesTapped(context);
          },
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _addShippingAddressesTapped(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.ADD_SHIPPING_ADDRESSES);
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
      isDefaultAddress: true,
    ),
    Address(
      name: "Ngô Bá Khá",
      phoneNumber: "09099909009",
      address: "Khu 2, Hoàng Cương, Thanh Ba, Phú Thọ.",
      isDefaultAddress: false,
    ),
    Address(
      name: "Phúc XO",
      phoneNumber: "09099909009",
      address: "Khu 2, Hoàng Cương, Thanh Ba, Phú Thọ.",
      isDefaultAddress: false,
    ),
  ];
}
