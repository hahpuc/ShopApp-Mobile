import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/home/home_bloc.dart';
import 'package:furniture_shop/presentation/pages/home/home_state.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  HomePageBloc _bloc = HomePageBloc(appRepository: locator.get());
  List<bool> _isSelected = [];

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: Text("HOME"),
      actions: [
        Icon(Icons.shopping_cart, color: AppColor.colorTextLight),
        Icon(
          Icons.chat_bubble_outline,
          color: AppColor.colorTextLight,
        )
      ],
      leading: Icon(
        Icons.search,
        color: AppColor.colorTextLight,
      ),
    );
  }

  _blocListener(BuildContext context, HomePageState state) async {
    // print("State $state");
    if (state is HomePageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<HomePageBloc, HomePageState>(
        listener: _blocListener,
        child: BlocBuilder<HomePageBloc, HomePageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is HomePageGetDataSuccessState) {
              //set isCheckList
              if (_isSelected.length != state.data.length) {
                for (int i = 0; i < state.data.length; i++) {
                  _isSelected.add(false);
                }
                _isSelected[0] = true;
              }
              return Column(
                children: [
                  _buildCategories(state.data),
                  _buildListProduct(context, state.data),
                ],
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

  _buildCategories(List<CategoriesResponseData> data) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            // set isCheckList element when onTap()
            onTap: () {
              setState(() {
                for (int i = 0; i < _isSelected.length; i++) {
                  _isSelected[i] = false;
                }
                _isSelected[index] = true;
                print(_isSelected);
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _isSelected[index]
                          ? AppColor.colorPrimary
                          : AppColor.boxIcon,
                      borderRadius:
                          BorderRadius.circular(AppDimen.radiusNormal),
                      boxShadow: [
                        _isSelected[index]
                            ? BoxShadow(
                                color: AppColor.colorBlack.withOpacity(0.25),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              )
                            : BoxShadow(),
                      ],
                    ),
                    child: Center(
                        child: SvgPicture.asset(data[index].image,
                            width: AppDimen.icon_size,
                            height: AppDimen.icon_size,
                            color: _isSelected[index]
                                ? AppColor.colorWhite
                                : AppColor.colorGrey))),
                CustomText(
                  data[index].name,
                  fontSize: FontSize.SMALL,
                  color: _isSelected[index]
                      ? AppColor.colorPrimary
                      : AppColor.colorGrey,
                )
              ]),
            ),
          );
        },
      ),
    );
  }

  _buildListProduct(BuildContext context, List<CategoriesResponseData> data) {
    int _indexSelected = 0;
    for (int i = 0; i < _isSelected.length; i++) {
      if (_isSelected[i]) {
        _indexSelected = i;
      }
    }
    List<ProductDetailResponseData>? list =
        _bloc.getProductWithCategoriesID(data[_indexSelected]);
    return Expanded(
      child: Container(
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
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Image.network(
                              item.images![0],
                              width: 150,
                              height: 200,
                            ),
                            Positioned(
                              right: AppDimen.spacing_1,
                              bottom: AppDimen.spacing_2,
                              child: Container(
                                child: Row(children: [
                                  CustomText(item.ratingStar.toString()),
                                  SvgPicture.asset(
                                    Assets.images.star.path,
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
                        // Stack(Image(
                        //   image: list[index].images,
                        // ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
