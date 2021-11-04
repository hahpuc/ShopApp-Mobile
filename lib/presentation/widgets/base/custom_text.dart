import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class CustomText extends StatelessWidget {
  CustomText(
    this.text, {
    this.fontFamily = FontFamily.nutinoSans,
    this.fontStyle = FontStyle.normal,
    this.color = Colors.black,
    this.fontSize = FontSize.MEDIUM,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.maxLine = 20,
    this.overflow = TextOverflow.ellipsis,
    this.align = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0,
  });
  final String text;
  final String fontFamily;
  final FontStyle fontStyle;
  final Color color;
  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final int maxLine;
  final TextOverflow overflow;
  final TextAlign align;
  final FontWeight fontWeight;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: fontFamily,
            color: color,
            fontSize: fontSize,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
          ),
          overflow: overflow,
          maxLines: maxLine,
          textAlign: align,
        ));
  }
}
