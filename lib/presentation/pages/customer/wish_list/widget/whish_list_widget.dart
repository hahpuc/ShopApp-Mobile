import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'icon_wishlist_widget.dart';

class WishListWidget extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final int? price;
  final bool? checked;
  final int? statusWhish;
  final OnPressed? removeFromWishList;

  const WishListWidget({
    this.title,
    this.imageUrl,
    this.price,
    this.checked = false,
    this.statusWhish = 0, //0: In stock ---- 1: Sold out
    this.removeFromWishList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
      child: Row(
        children: [
          _buildRadioCheckbox(),
          _buildImage(),
          _buildInfo(),
          Spacer(),
          _buildButtonMore(context),
        ],
      ),
    );
  }

  Widget _buildRadioCheckbox() {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: statusWhish == 1 ? Colors.white : Colors.black,
        border: Border.all(
          width: 1,
          color: statusWhish == 1 ? AppColor.colorGrey : Colors.transparent,
        ),
      ),
      child: IconButton(
        onPressed: () {
          print('CHOOSE PRODUCT');
        },
        icon: Icon(
          Icons.check,
          size: 16.0,
          color:
              statusWhish == 1 ? AppColor.colorGrey : AppColor.colorGreyLight,
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? ''),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatus(),
        _buildTitle(),
        _buildPrice(),
      ],
    );
  }

  Widget _buildStatus() {
    switch (statusWhish) {
      case 0:
        return SizedBox.shrink();
      case 1:
        return CustomText(
          'Sold out',
          color: Color(0xFFFF5148),
          fontSize: FontSize.SMALL,
          fontWeight: FontWeight.w700,
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildButtonMore(BuildContext context) {
    return IconWishList(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _buildBottomSheet(context);
          },
        );
      },
      icon: Icons.more_vert_outlined,
    );
  }

  void changeColor() {
    print('changeColor');
  }

  removeWhishlist(BuildContext context) {
    removeFromWishList!.call();
    Navigator.pop(context);
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimen.spacing_3,
        horizontal: AppDimen.spacing_2,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderBottomSheet(context),
            customDivider(),
            _buildTileBottomSheet(
              icon: Icons.color_lens_outlined,
              title: 'Change color',
              onTap: changeColor,
            ),
            customDivider(),
            _buildTileBottomSheet(
              icon: Icons.delete_outline,
              title: 'Remove from Whishlist',
              onTap: () => removeWhishlist(context),
            ),
            const SizedBox(height: 10),
            _buildFooterButtonSheet(),
          ],
        ),
      ),
    );
  }

  Widget customDivider() {
    return Divider(
      thickness: 1,
      color: AppColor.colorGreyLight,
    );
  }

  Widget _buildHeaderBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimen.spacing_1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            'Options',
            fontSize: FontSize.BIG,
            fontWeight: FontWeight.w600,
          ),
          IconWishList(
            icon: Icons.close,
            color: AppColor.colorGrey,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTileBottomSheet(
      {IconData? icon, String? title, Function()? onTap}) {
    return InkWell(
      onTap: onTap!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
        child: Row(
          children: [
            IconWishList(icon: icon, color: AppColor.colorGrey),
            const SizedBox(width: AppDimen.spacing_2),
            CustomText(
              title!,
              fontSize: FontSize.BIG,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButtonSheet() {
    return PrimaryButton(
      title: 'Write review',
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: CustomText(
          title!,
          fontSize: FontSize.MEDIUM,
          color: statusWhish == 1 ? AppColor.colorTextLight : Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return CustomText(
      '\$ ${price!.toStringAsFixed(2)}',
      fontSize: FontSize.SMALL,
      fontWeight: FontWeight.w700,
      color: statusWhish == 1 ? AppColor.colorTextLight : Colors.black,
    );
  }
}
