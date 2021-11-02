import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class OrderCard extends StatelessWidget {
  final String? idOrder;
  final String? date;
  final int? quantity;
  final double? total;
  final int? status;

  const OrderCard({
    this.idOrder = '123456789',
    this.date,
    this.total = 0,
    this.quantity = 1,
    this.status = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Navigator to Order Detail');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.verticalSpacing,
          vertical: AppDimen.spacing_1,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 12,
                    color: AppColor.colorPrimary.withOpacity(.15),
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimen.verticalSpacing),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorGreyLight,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            'Order #$idOrder',
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            '$date',
            fontSize: FontSize.SMALL,
            color: AppColor.colorGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppDimen.verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailInfo(title: 'Quantity', number: '$quantity'),
          _buildDetailInfo(
            title: 'Total Amount',
            number: '${total!.toStringAsFixed(3)} \$',
          ),
          _buildStatusOrder(),
        ],
      ),
    );
  }

  Widget _buildDetailInfo({String? title, String? number}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CustomText(
            '${title!}: ',
            color: AppColor.colorGrey,
            fontWeight: FontWeight.w500,
          ),
          CustomText(number!, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }

  Widget _buildStatusOrder() {
    switch (status) {
      case 0: // cancelled
        return _buildStatusStyle(
          // icon: Icons.local_shipping_outlined,
          title: 'Cancelled',
          color: Colors.red,
        );
      case 1: //in processing
        return _buildStatusStyle(
          icon: Icons.watch_later_outlined,
          title: 'In Processing',
          color: AppColor.colorPrimary,
        );
      default: //delivered
        return _buildStatusStyle(
          icon: Icons.local_shipping_outlined,
          title: 'Delivered',
          color: Colors.green,
        );
    }
  }

  Widget _buildStatusStyle({IconData? icon, String? title, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
      child: Row(
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    icon,
                    size: AppDimen.spacing_4,
                    color: AppColor.colorPrimary,
                  ),
                )
              : SizedBox.shrink(),
          CustomText(
            title!,
            color: color!,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
