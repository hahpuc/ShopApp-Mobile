import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/admin/product/edit_product_admin_page.dart';
import 'package:furniture_shop/presentation/pages/customer/product_detail/widget/product_picture_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/presentation/widgets/quantity_view.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'bloc/product_detail_bloc.dart';
import 'bloc/product_detail_state.dart';

enum ProductDetailType {
  Customer,
  Admin,
}

class ProductDetailPage extends StatefulWidget {
  final ProductDetailType typeProduct;

  const ProductDetailPage({
    this.typeProduct = ProductDetailType.Customer,
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with AfterLayoutMixin {
  final PageController _pageController = PageController(initialPage: 0);

  ProductDetailPageBloc _bloc =
      ProductDetailPageBloc(appRepository: locator.get());

  int currentQuantity = 1;

  @override
  void afterFirstFrame(BuildContext context) {
    // HARD CODE HERE
    // _bloc.getProductDetailsData('6166b1a5f1300453bc24adb5');

    _bloc.getProductDetail();
  }

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

  _blocListener(BuildContext context, ProductDetailPageState state) async {
    print("State $state");
    if (state is ProductDetailPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is ProductDetailGetDataFailed) {
      EasyLoading.showError(state.msg);
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<ProductDetailPageBloc, ProductDetailPageState>(
        listener: _blocListener,
        child: BlocBuilder<ProductDetailPageBloc, ProductDetailPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ProductDetailGetDataSuccess)
              return Stack(
                children: [
                  Container(height: double.infinity, width: double.infinity),
                  _buildProductInformation(),
                  _buildFooterButton(),
                ],
              );

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildFooterButton() {
    switch (widget.typeProduct) {
      case ProductDetailType.Admin:
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: AppDimen.footerButtonHeight,
            child: Row(
              children: [
                SizedBox(width: AppDimen.horizontalSpacing),
                IconButton(
                  iconSize: 50.0,
                  onPressed: () {},
                  icon: Image(
                    image: Assets.images.icBin,
                  ),
                ),
                SizedBox(width: AppDimen.spacing_1),
                Expanded(
                  child: PrimaryButton(
                    title: 'Edit product',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EditAdminProductPage(
                            typeEdit: EditAdminType.Edit,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: AppDimen.horizontalSpacing),
              ],
            ),
          ),
        );
      default:
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: AppDimen.footerButtonHeight,
            child: Row(
              children: [
                SizedBox(width: AppDimen.horizontalSpacing),
                IconButton(
                  iconSize: 50.0,
                  onPressed: () {},
                  icon: Image(
                    image: Assets.images.icAddWishList,
                  ),
                ),
                SizedBox(width: AppDimen.spacing_1),
                Expanded(
                  child: PrimaryButton(
                    title: 'Add to cart',
                    onPressed: _onAddToCartButton,
                  ),
                ),
                SizedBox(width: AppDimen.horizontalSpacing),
              ],
            ),
          ),
        );
    }
  }

  void _onAddToCartButton() {
    EasyLoading.showSuccess('Added to cart');
  }

  Widget _buildProductInformation() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureList(
            pageController: _pageController,
            images: [
              "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg",
              "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg",
              "https://res.cloudinary.com/dynk5q1io/image/upload/v1634120354/products/Gaming%20Table/z36qyy9awic0eltow6qi.jpg"
            ],
          ),
          _buildDetailInfo(),
          SizedBox(height: AppDimen.footerButtonHeight),
        ],
      ),
    );
  }

  Widget _buildDetailInfo() {
    return Container(
      padding: const EdgeInsets.all(AppDimen.spacing_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText('Folding Computer Desk', fontSize: FontSize.BIG_1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                '59' + ' \$',
                fontSize: FontSize.BIG_2,
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
          SizedBox(height: AppDimen.verticalSpacing),
          CustomText(
            'The computer table can be folded, you can fold it and put it away, which can save your space',
            fontWeight: FontWeight.w300,
          ),
          SizedBox(height: AppDimen.verticalSpacing),
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
          "(" + '59' + " review)",
          color: AppColor.colorTextLight,
          fontSize: FontSize.SMALL,
        ),
      ],
    );
  }

  void _onMinusTapped() {
    if (currentQuantity == 0) return;
    setState(() {
      currentQuantity--;
    });
  }

  void _onPlusTapped() {
    setState(() {
      currentQuantity++;
    });
  }
}
