import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/data/model/response/test_product.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_state.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class HomeTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTabPageState();
  }
}

class _HomeTabPageState extends State<HomeTabPage> with AfterLayoutMixin {
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
            Navigator.pushNamed(context, RoutePaths.MY_CART);
          },
          icon: SvgPicture.asset(
            Assets.images.icCart.path,
            width: AppDimen.icon_size,
            height: AppDimen.icon_size,
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutePaths.CHAT_PAGE);
            },
            icon: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.icMessage.path,
                    width: AppDimen.icon_size,
                    height: AppDimen.icon_size,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.brightness_1,
                      color: AppColor.dotMessage,
                      size: 6,
                    ),
                  )
                ],
              ),
            )),
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
                    Navigator.of(context).pushNamed(RoutePaths.PRODUCT_DETAIL);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  image: NetworkImage(item.images![0]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            right: AppDimen.spacing_1,
                            bottom: AppDimen.spacing_2,
                            child: Container(
                              child: Row(
                                children: [
                                  CustomText(
                                    item.ratingStar.toString(),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4.0),
                                  SvgPicture.asset(
                                    Assets.images.icStar.path,
                                    width: AppDimen.spacing_2,
                                    height: AppDimen.spacing_2,
                                  ),
                                ],
                              ),
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
}
