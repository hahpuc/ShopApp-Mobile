import 'package:flutter/material.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class DockButton extends StatelessWidget {
  final String name;

  DockButton({required this.name});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);
    final buttonWidth = MediaQuery.of(context).size.width - 32.0;
    return Container(
      width: buttonWidth,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: borderRadius, color: Colors.black.withOpacity(0.8)),
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: FontSize.MEDIUM),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
