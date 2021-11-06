import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'base/custom_text.dart';

class TimeLiveView extends StatefulWidget {
  const TimeLiveView({Key? key}) : super(key: key);

  @override
  _TimeLiveViewState createState() => _TimeLiveViewState();
}

class _TimeLiveViewState extends State<TimeLiveView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => _buildRow(index)),
    );
  }

  Widget _buildRow(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle Status
        SizedBox(
          width: 48.0,
          child: Column(
            children: [
              // build circle container
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: AppColor.colorPrimary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),

              if (index < 2)
                Container(
                  width: 1.0,
                  height: 48.0,
                  color: AppColor.colorGreyLight,
                ),
            ],
          ),
        ),

        // Information
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'To Pay',
            ),
            SizedBox(height: 16.0),
            CustomText(
              '09-09-2021 21:15',
              fontSize: FontSize.SMALL_1,
              color: AppColor.colorTextLight,
            )
          ],
        )
      ],
    );
  }
}
