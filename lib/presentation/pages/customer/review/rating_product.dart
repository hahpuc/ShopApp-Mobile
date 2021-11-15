import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class RatingProduct extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final int? reviewCount;

  const RatingProduct(
      {Key? key, this.imageUrl, this.name, this.rating, this.reviewCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
            image: DecorationImage(
                image: NetworkImage(this.imageUrl ?? ''), fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              name ?? '',
              fontSize: FontSize.SMALL,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColor.colorRatingStar,
                ),
                SizedBox(
                  width: 3,
                ),
                CustomText(
                  '${this.rating}',
                  fontSize: FontSize.BIG,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            CustomText(
              "(${this.reviewCount} reviews)",
              fontSize: FontSize.SMALL,
              color: AppColor.colorTextLight,
            ),
          ],
        ),
      ],
    );
  }
}
