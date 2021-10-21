import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'custom_text.dart';

class CustomBottomSizeStyle {
  static const WRAP_CONTENT = 0;
  static const MATCH_PARENT = 1;
}

class CustomButton extends StatelessWidget {
  CustomButton(
    this.text, {
    this.textColor = Colors.white,
    this.textAlignment = TextAlign.center,
    this.fontSize = FontSize.MEDIUM,
    this.padding = const EdgeInsets.all(8),
    this.tintColor = Colors.white,
    this.backgroundColor = AppColor.colorPrimary,
    this.borderRadius = 8,
    this.borderWidth = 0,
    this.borderOpacity = 0.3,
    this.sizeStyle = CustomBottomSizeStyle.WRAP_CONTENT,
    this.fontWeight = FontWeight.w500,
    this.rightIcon,
    this.onTap,
  });

  final String text;
  final Color textColor;
  final TextAlign textAlignment;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Color tintColor;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final double borderOpacity;
  final int sizeStyle;
  final Widget? rightIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return sizeStyle == CustomBottomSizeStyle.WRAP_CONTENT
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [_buildChild()],
          )
        : _buildChild();
  }

  Widget _buildChild() {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
                color: Colors.grey.withOpacity(borderOpacity),
                width: borderWidth)),
        child: InkWell(
          borderRadius: BorderRadius.circular((borderRadius - 2) < 0
              ? 0
              : borderRadius - 2), // Prevent ripple overflow
          child: Container(
            padding: padding,
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rightIcon != null) ..._buildRightIcon(),
                  CustomText(
                    text,
                    overflow: TextOverflow.visible,
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    align: textAlignment,
                  ),
                ],
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  _buildRightIcon() {
    return [
      SizedBox(
        width: 24.0,
        child: rightIcon,
      ),
      SizedBox(width: 12.0),
    ];
  }
}
