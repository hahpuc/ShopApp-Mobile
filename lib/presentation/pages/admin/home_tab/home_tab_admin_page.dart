import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/admin/home_tab/home_tab_admin_bloc.dart';
import 'package:furniture_shop/presentation/pages/admin/home_tab/home_tab_admin_state.dart';
import 'package:furniture_shop/presentation/pages/admin/product/edit_product_admin_page.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/widget/icon_wishlist_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

List<CategoriesModel> listCategories = [
  CategoriesModel(
      id: '6166a79e1ca0b44b1d0e9380',
      name: "Desk",
      image: Assets.images.icArmchair.path),
  CategoriesModel(
      id: '61d6b3750d10587b01f6e3ec',
      name: "Chair",
      image: Assets.images.icChair.path),
  CategoriesModel(
      id: '616a8f57a845933851fbdecf',
      name: "Lamp",
      image: Assets.images.icLamp.path),
  CategoriesModel(
      id: '61d6b37c0d10587b01f6e3ef',
      name: "Bed",
      image: Assets.images.icBed.path),
  CategoriesModel(
      id: '619d07ded96396890640b8e7',
      name: "TV",
      image: Assets.images.icTv.path),
];

class HomeTabAdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTabAdminPageState();
  }
}

class _HomeTabAdminPageState extends State<HomeTabAdminPage>
    with
        AfterLayoutMixin,
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin {
  HomeTabAdminPageBloc _bloc =
      HomeTabAdminPageBloc(appRepository: locator.get());

  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: listCategories.length);
    tabController.addListener(_handleSelected);
    super.initState();
  }

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getProductWithCategory(listCategories[0].id ?? '');
  }

  _blocListener(BuildContext context, HomeTabAdminPageState state) async {
    if (state is HomeTabAdminPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  void _handleSelected() {
    _currentIndex.value = tabController.index;
    _bloc.getProductWithCategory(listCategories[tabController.index].id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
        create: (context) => _bloc,
        child: DefaultTabController(
          length: listCategories.length,
          child: Builder(builder: (BuildContext context) {
            return Scaffold(
                appBar: _buildAppBar(),
                body: TabBarView(controller: tabController, children: [
                  for (int i = 0; i < listCategories.length; i++)
                    _buildListProduct(listCategories[i].id ?? '')
                ]));
          }),
        ));
  }

  CustomAppBar _buildAppBar() {
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
      leading: Container(),
      bottom: PreferredSize(
        preferredSize: const Size(0.0, 80.0),
        child: TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            controller: tabController,
            tabs: [
              for (int i = 0; i < listCategories.length; i++)
                ValueListenableBuilder<int>(
                    valueListenable: _currentIndex,
                    builder: (BuildContext context, int value, Widget? child) {
                      return Column(children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: AppDimen.spacing_1),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: value == i
                                ? AppColor.colorPrimary
                                : AppColor.boxIcon,
                            borderRadius:
                                BorderRadius.circular(AppDimen.radiusNormal),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              listCategories[i].image ??
                                  Assets.images.icArmchair.path,
                              width: AppDimen.icon_size,
                              height: AppDimen.icon_size,
                              color: value == i
                                  ? AppColor.colorWhite
                                  : AppColor.colorGrey,
                            ),
                          ),
                        ),
                        CustomText(
                          listCategories[i].name ?? '',
                          fontSize: FontSize.SMALL,
                          color: value == i
                              ? AppColor.colorPrimary
                              : AppColor.colorGrey,
                        )
                      ]);
                    }),
            ]),
      ),
    );
  }

  Widget _buildListProduct(String id) {
    List<ProductDetailModel>? list;
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.getProductWithCategory(
            listCategories[tabController.index].id ?? '');
      },
      child: BlocListener<HomeTabAdminPageBloc, HomeTabAdminPageState>(
        listener: _blocListener,
        child: BlocBuilder<HomeTabAdminPageBloc, HomeTabAdminPageState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is HomeTabAdminPageGetDataSuccessState) {
                list = state.data;
                return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: AppDimen.spacing_3,
                        horizontal: AppDimen.spacing_2),
                    child: _buildGridView(list ?? []));
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  Widget _buildGridView(List<ProductDetailModel>? list) {
    return Container(
      child: GridView.builder(
          itemCount: list?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: AppDimen.spacing_2,
            mainAxisSpacing: AppDimen.spacing_2,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (list != null) {
              ProductDetailModel item = list[index];
              return Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RoutePaths.ADMIN_EDIT_PRODUCT_PAGE,
                        arguments: EditAdminType.Edit);
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
                              item.images?[0].imageUrl ?? '',
                              width: 150,
                              height: 200,
                              fit: BoxFit.cover,
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
            } else {
              return Container();
            }
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
