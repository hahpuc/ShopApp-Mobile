import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class PaymentMethodWidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String text;
  final ValueChanged<T?> onChanged;
  final String paymentMethodIcon;
  final String paymentMethodName;

  const PaymentMethodWidget({
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
    required this.paymentMethodIcon,
    required this.paymentMethodName,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;
    return isSelected
        ? Icon(Icons.check_circle)
        : Icon(Icons.check_circle_outline);
  }

  Widget _buildText() {
    return CustomText(
      text,
      fontFamily: FontFamily.nutinoSans,
      fontSize: FontSize.MEDIUM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  _buildLabel(),
                  const SizedBox(width: 10),
                  _buildText(),
                ],
              ),
              MethodWidget(
                methodIcon: paymentMethodIcon,
                methodName: paymentMethodName,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MethodWidget extends StatefulWidget {
  final String methodIcon;
  final String methodName;
  MethodWidget({Key? key, required this.methodIcon, required this.methodName})
      : super(key: key);

  @override
  State<MethodWidget> createState() => _MethodWidgetState();
}

class _MethodWidgetState extends State<MethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppDimen.spacing_2, vertical: AppDimen.spacing_1),
      decoration: BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
        boxShadow: [
          BoxShadow(
            color: AppColor.colorBoxShadowProfile.withOpacity(0.2),
            blurRadius: 40,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIcon(),
          _buildName(),
        ],
      ),
    );
  }

  _buildIcon() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_1, horizontal: AppDimen.spacing_2),
      margin: EdgeInsets.symmetric(
          horizontal: AppDimen.spacing_3, vertical: AppDimen.spacing_4),
      decoration: BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
        boxShadow: [
          BoxShadow(
            color: AppColor.colorBlack.withOpacity(0.08),
            blurRadius: 25,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Image.asset(
        widget.methodIcon,
        width: 24,
        height: 24,
      ),
    );
  }

  _buildName() {
    return CustomText(
      widget.methodName,
      color: AppColor.colorBlack,
      fontFamily: FontFamily.nutinoSans,
      fontWeight: FontWeight.bold,
      fontSize: FontSize.SMALL,
    );
  }
}
