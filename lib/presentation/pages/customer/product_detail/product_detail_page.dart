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
    _bloc.getProductDetailsData('6166b1a5f1300453bc24adb5');
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
                  _buildProductInformation(state.data),
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
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: AppDimen.horizontalSpacing),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildProductInformation(ProductDetailModel data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureList(
            pageController: _pageController,
            images: data.images,
          ),
          _buildDetailInfo(data),
          SizedBox(height: AppDimen.footerButtonHeight),
        ],
      ),
    );
  }

  Widget _buildDetailInfo(ProductDetailModel data) {
    return Container(
      padding: const EdgeInsets.all(AppDimen.spacing_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(data.name ?? '', fontSize: FontSize.BIG_1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data.price.toString() + ' \$',
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
          _buildRatingView(data),
          SizedBox(height: AppDimen.verticalSpacing),
          CustomText(
            data.description ?? '',
            fontWeight: FontWeight.w300,
          ),
          SizedBox(height: AppDimen.verticalSpacing),
        ],
      ),
    );
  }

  Widget _buildRatingView(ProductDetailModel data) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColor.colorRatingStar,
          size: AppDimen.icon_size_small,
        ),
        SizedBox(width: AppDimen.spacing_1),
        CustomText(
          data.ratingStar.toString(),
          color: AppColor.colorRatingStar,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(width: AppDimen.spacing_1),
        CustomText(
          "(" + data.reviews.toString() + " review)",
          color: AppColor.colorTextLight,
          fontSize: FontSize.SMALL,
        ),
      ],
    );
  }

  void _onMinusTapped() {}

  void _onPlusTapped() {}
}
