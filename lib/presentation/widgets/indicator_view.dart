import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IndicatorView extends StatelessWidget {
  final int count;
  final PageController pageController;
  final Color color;

  IndicatorView({
    required this.pageController,
    required this.count,
    this.color = AppColor.indicator,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
        controller: pageController,
        count: count,
        effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: 6,
              height: 6,
              color: color,
              borderRadius: BorderRadius.circular(16),
              dotBorder: DotBorder(
                padding: 3,
                width: 1,
                color: color,
              ),
            ),
            dotDecoration: DotDecoration(
              width: 6,
              height: 6,
              color: color,
              borderRadius: BorderRadius.circular(16),
            )),
        onDotClicked: (index) {});
  }
}
