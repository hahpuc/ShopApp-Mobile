import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/product_detail/widget/product_picture_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int currentQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: AppBackButton(imgColor: Colors.black),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildProductInformation(),
        _buildFooterButton(),
      ],
    );
  }

  Widget _buildFooterButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        child: Row(
          children: [
            SizedBox(width: 16.0),
            Expanded(
              child: PrimaryButton(
                title: 'Add to cart',
                onPressed: () {},
              ),
            ),
            SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInformation() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureList(pageController: _pageController),
          _buildDetailInfo()
        ],
      ),
    );
  }

  Widget _buildDetailInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText('Modern Lamp', fontSize: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                '50.00 \$',
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
              ),
              QuantityView(
                quantity: currentQuantity,
                onMinusTapped: _onMinusTapped,
                onPlusTapped: _onPlusTapped,
              )
            ],
          ),
          _buildRatingView(),
          SizedBox(height: 16.0),
          CustomText(
            'Morden Lamp is made of by natural wood.The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
            fontWeight: FontWeight.w300,
          )
        ],
      ),
    );
  }

  Widget _buildRatingView() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColor.colorRatingStar,
          size: AppDimen.icon_size_small,
        ),
        SizedBox(width: AppDimen.spacing_1),
        CustomText(
          '4.5',
          color: AppColor.colorRatingStar,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(width: AppDimen.spacing_1),
        CustomText(
          "(233 review)",
          color: AppColor.colorTextLight,
          fontSize: FontSize.SMALL,
        ),
      ],
    );
  }

  void _onMinusTapped() {}

  void _onPlusTapped() {}
}

class QuantityView extends StatefulWidget {
  const QuantityView({
    Key? key,
    this.quantity = 1,
    required this.onMinusTapped,
    required this.onPlusTapped,
  }) : super(key: key);

  final int? quantity;
  final Function onMinusTapped;
  final Function onPlusTapped;

  @override
  _QuantityViewState createState() => _QuantityViewState();
}

class _QuantityViewState extends State<QuantityView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            widget.onMinusTapped();
          },
          icon: Icon(Icons.remove,
              color: Colors.black, size: AppDimen.icon_size_small),
        ),
        CustomText(
          widget.quantity.toString(),
          fontSize: 16.0,
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {
            widget.onPlusTapped();
          },
          icon: Icon(Icons.add,
              color: Colors.black, size: AppDimen.icon_size_small),
        ),
      ],
    );
  }
}
