import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Column(
        children: List.generate(
            errors.length, (index) => formErrorText(error: errors[index]!)),
      ),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        SvgPicture.asset($AssetsImagesGen().icError.path),
        SizedBox(
          width: 10,
        ),
        Text(error),
      ],
    );
  }
}