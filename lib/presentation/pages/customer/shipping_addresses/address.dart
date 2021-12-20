import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/presentation/widgets/shipping_information_widget.dart';
import 'package:furniture_shop/values/dimens.dart';

class Address extends StatelessWidget {
  final String? name;
  final String? phoneNumber;
  final String? address;
  final bool? isDefaultAddress;
  final OnPressed? onTap;
  Address(
      {required this.name,
      required this.phoneNumber,
      required this.address,
      required this.isDefaultAddress,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: onTap,
              child: Icon(
                isDefaultAddress == true
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                size: 18.0,
              ),
            ),
            SizedBox(width: AppDimen.horizontalSpacing),
            CustomText('Use as the shipping address'),
          ],
        ),
        SizedBox(height: AppDimen.verticalSpacing),
        ShippingInformation(
          name: this.name ?? '',
          phoneNumber: this.phoneNumber ?? '',
          address: this.address ?? '',
        ),
        SizedBox(
          height: AppDimen.verticalSpacing,
        )
      ],
    );
  }
}
