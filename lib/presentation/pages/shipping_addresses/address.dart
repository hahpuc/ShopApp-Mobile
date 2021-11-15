import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/shipping_information_widget.dart';
import 'package:furniture_shop/values/dimens.dart';

class Address extends StatelessWidget {
  final String? name;
  final String? phoneNumber;
  final String? address;
  final bool? isDefaultAddress;

  Address(
      {required this.name,
      required this.phoneNumber,
      required this.address,
      required this.isDefaultAddress});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              isDefaultAddress == true
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              size: 32.0,
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
