import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import '/generated/assets/fonts.gen.dart';
import '/presentation/widgets/base/custom_appbar.dart';
import '/presentation/widgets/base/custom_text.dart';
import '/presentation/widgets/base/custom_textfield.dart';
import '/values/dimens.dart';
import '/values/font_sizes.dart';

class AddShippingAddressPage extends StatefulWidget {
  const AddShippingAddressPage({Key? key}) : super(key: key);

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: CustomText(
          'Add Shipping Address',
          fontFamily: FontFamily.gelasio,
          fontSize: FontSize.BIG,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimen.spacing_2,
          horizontal: AppDimen.spacing_2 - 4,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFormInput(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormInput() {
    return Column(
      children: [
        _buildTextField(
          title: 'Full name',
          controller: nameController,
        ),
        _buildTextField(
          title: 'Phone number',
          controller: phoneController,
        ),
        _buildTextField(
          title: 'Address',
          controller: addressController,
        ),
      ],
    );
  }

  Widget _buildButton() {
    return PrimaryButton(
      title: 'Add new address',
    );
  }

  Widget _buildTextField({
    String? title,
    TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimen.spacing_2),
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: AppDimen.spacing_1 + 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.colorGreyLight,
        ),
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
      ),
      child: CustomTextField(
        textController: controller!,
        labelText: title!,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
