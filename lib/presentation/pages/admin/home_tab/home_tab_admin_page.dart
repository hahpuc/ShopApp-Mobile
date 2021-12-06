import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/test_product.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_state.dart';
import 'package:furniture_shop/presentation/pages/customer/product_detail/product_detail_page.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/widget/icon_wishlist_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class HomeAdminTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeAdminTabPageState();
  }
}

class _HomeAdminTabPageState extends State<HomeAdminTabPage>
    with AfterLayoutMixin {
  HomeTabPageBloc _bloc = HomeTabPageBloc(appRepository: locator.get());
  int _currentIndex = 1;
  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getCategoriesData();
  }

  _blocListener(BuildContext context, HomeTabPageState state) async {
    if (state is HomeTabPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<HomeTabPageBloc, HomeTabPageState>(
        listener: _blocListener,
        child: BlocBuilder<HomeTabPageBloc, HomeTabPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is HomeTabPageGetDataSuccessState) {
              return DefaultTabController(
                length: state.data.length,
                child: Builder(builder: (BuildContext context) {
                  final TabController tabController =
                      DefaultTabController.of(context)!;
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {
                      log(tabController.index.toString());
                      setState(() {
                        _currentIndex = tabController.index + 1;
                      });
                    }
                  });
                  return Scaffold(
                      appBar: _buildAppBar(state.data),
                      body: TabBarView(children: [
                        for (int i = 0; i < 6; i++) _buildListProduct(i + 1)
                      ]));
                }),
              );
            }

            return Container(
              color: Colors.red,
              height: 50,
            );
          },
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar(List<CategoriesResponseData> data) {
    return CustomAppBar(
      title: CustomText(
        'Home',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return _buildBottomSheet(context);
              },
            );
          },
          icon: Image.asset(
            Assets.images.icAddNew.path,
            width: AppDimen.icon_size,
            height: AppDimen.icon_size,
          ),
        ),
      ],
      leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.images.icSearch.path,
            width: AppDimen.icon_size,
            height: AppDimen.icon_size,
          )),
      bottom: PreferredSize(
        preferredSize: const Size(0.0, 80.0),
        child: TabBar(
            isScrollable: true,
            labelColor: Colors.amber,
            indicatorColor: Colors.transparent,
            onTap: (index) {
              setState(() {
                _currentIndex = index + 1;
              });
            },
            tabs: [
              for (final item in data)
                Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _currentIndex == item.id
                          ? AppColor.colorPrimary
                          : AppColor.boxIcon,
                      borderRadius:
                          BorderRadius.circular(AppDimen.radiusNormal),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        item.image,
                        width: AppDimen.icon_size,
                        height: AppDimen.icon_size,
                        color: _currentIndex == item.id
                            ? AppColor.colorWhite
                            : AppColor.colorGrey,
                      ),
                    ),
                  ),
                  CustomText(
                    item.name,
                    fontSize: FontSize.SMALL,
                    color: _currentIndex == item.id
                        ? AppColor.colorPrimary
                        : AppColor.colorGrey,
                  )
                ]),
            ]),
      ),
    );
  }

  _buildListProduct(int id) {
    List<ProductTest>? list = _bloc.getProductWithCategoriesID(id);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_3, horizontal: AppDimen.spacing_2),
      child: Container(
        child: GridView.builder(
            itemCount: list?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: AppDimen.spacing_2,
              mainAxisSpacing: AppDimen.spacing_2,
            ),
            itemBuilder: (BuildContext context, int index) {
              final item = list![index];
              return Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductDetailPage(
                            typeProduct: ProductDetailType.Admin),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              item.images![0],
                              width: 150,
                              height: 200,
                            ),
                          ),
                          Positioned(
                            right: AppDimen.spacing_1,
                            bottom: AppDimen.spacing_2,
                            child: Container(
                              child: Row(children: [
                                CustomText(item.ratingStar.toString()),
                                SvgPicture.asset(
                                  Assets.images.icStar.path,
                                  width: AppDimen.spacing_2,
                                  height: AppDimen.spacing_2,
                                )
                              ]),
                            ),
                          )
                        ],
                      ),
                      CustomText(
                        item.name ?? "",
                        fontSize: FontSize.SMALL,
                        color: AppColor.colorGrey,
                      ),
                      CustomText(
                        item.price.toString() + r"$",
                        fontSize: FontSize.SMALL,
                        color: AppColor.colorBlack,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
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
              title: 'Category',
              onTap: () {},
            ),
            customDivider(),
            _buildTileBottomSheet(
              icon: Icons.delete_outline,
              title: 'Product',
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RoutePaths.ADMIN_EDIT_PRODUCT_PAGE);
              },
            ),
          ],
        ),
      ),
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

  Widget customDivider() {
    return Divider(
      thickness: 1,
      color: AppColor.colorGreyLight,
    );
  }
}
