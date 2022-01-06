import 'package:flutter/material.dart';
import 'package:furniture_shop/data/model/response/order_response.dart';
import 'package:furniture_shop/utils/datetime_utils.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'base/custom_text.dart';

class TimeLiveView extends StatefulWidget {
  final int statusOrder;

  final List<StatusModel>? statusList;
  final OrderDataModel? orderData;

  const TimeLiveView({
    this.statusOrder = 1,
    this.statusList,
    this.orderData,
    Key? key,
  }) : super(key: key);

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
                  color: index <= widget.statusList!.length - 1
                      ? AppColor.colorPrimary
                      : AppColor.colorGreyLight,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),

              if (index < 2)
                Container(
                  width: 1.0,
                  height: 48.0,
                  color: index <= widget.statusList!.length - 1
                      ? AppColor.colorPrimary
                      : AppColor.colorGreyLight,
                ),
            ],
          ),
        ),

        // Information
        index <= widget.statusList!.length - 1
            ? _buildTime(index)
            : _buildTextTimeLine(index),
      ],
    );
  }

  Widget _buildTime(int index) {
    switch (index) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Order',
            ),
            SizedBox(height: 16.0),
            CustomText(
              DateTimeUtils.convertToDateTimeString(
                  widget.orderData?.orderTime ?? ''),
              fontSize: FontSize.SMALL_1,
              color: AppColor.colorTextLight,
            )
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'To Ship',
            ),
            SizedBox(height: 16.0),
            CustomText(
              DateTimeUtils.convertToDateTimeString(
                  widget.orderData?.shipTime ?? ''),
              fontSize: FontSize.SMALL_1,
              color: AppColor.colorTextLight,
            )
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Completed',
            ),
            SizedBox(height: 16.0),
            CustomText(
              DateTimeUtils.convertToDateTimeString(
                  widget.orderData?.completedTime ?? ''),
              fontSize: FontSize.SMALL_1,
              color: AppColor.colorTextLight,
            )
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Cancelled',
            ),
          ],
        );
    }
  }

  Widget _buildTextTimeLine(int index) {
    switch (index) {
      case 0:
        return CustomText(
          'Paid',
          color: AppColor.colorGrey,
        );
      case 1:
        return CustomText(
          'To Ship',
          color: AppColor.colorGrey,
        );
      case 2:
        return CustomText(
          'Completed',
          color: AppColor.colorGrey,
        );
      default:
        return CustomText(
          'Paid',
          color: AppColor.colorGrey,
        );
    }
  }
}
