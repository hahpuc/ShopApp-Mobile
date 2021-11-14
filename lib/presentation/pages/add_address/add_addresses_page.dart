import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/base/tap_outside_to_unfocus.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class AddAddresses extends StatefulWidget {
  @override
  State<AddAddresses> createState() => _AddAddressesState();
}

class _AddAddressesState extends State<AddAddresses> {
  final name = TextEditingController();

  final phoneNumber = TextEditingController();

  final address = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    name.dispose();
    phoneNumber.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideToUnfocus(
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }

  CustomAppBar _buildAppbar() {
    return CustomAppBar(
      title: CustomText(
        'Add Shipping Addresses',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
    );
  }

  Widget _buildBody() {
    return FooterScrollView(
      body: _buildListField(),
      footer: _buildFooter(),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50.0,
        child: PrimaryButton(
          title: 'Add new addresses',
          onPressed: () {
            print("name: ${this.name.text}");
          },
        ),
      ),
    );
  }

  Widget _buildListField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          _buildNameField(),
          SizedBox(
            height: 15,
          ),
          _buildPhoneNumberField(),
          SizedBox(
            height: 15,
          ),
          _buildAddressField(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.colorGrey),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CustomText(
            "Full name",
            color: AppColor.colorTextLight,
            fontSize: FontSize.SMALL_1,
          ),
          TextField(
            keyboardType: TextInputType.name,
            controller: name,
            decoration: InputDecoration(
                fillColor: Colors.white, border: InputBorder.none),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.colorGrey),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CustomText(
            "Phone number",
            color: AppColor.colorTextLight,
            fontSize: FontSize.SMALL_1,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneNumber,
            decoration: InputDecoration(
                fillColor: Colors.white, border: InputBorder.none),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.colorGrey),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CustomText(
            "Address",
            color: AppColor.colorTextLight,
            fontSize: FontSize.SMALL_1,
          ),
          TextField(
            controller: address,
            decoration: InputDecoration(
                fillColor: Colors.white, border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
