import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/categories_response.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
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
    return Expanded(
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
    int _indexSelected;
    for (int i = 0; i < _isSelected.length; i++) {
      if (_isSelected[i]) {
        _indexSelected = i;
      }
    }
    List<ProductDetailResponseData>? list =
        _bloc.getProductWithCategoriesID(data[1]);
    print(list);
    return Expanded(
      child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.red,
            );
          }),
    );
  }
}
