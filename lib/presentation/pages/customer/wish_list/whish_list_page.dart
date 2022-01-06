import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/local/wish_list.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/bloc/wish_list_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/bloc/wish_list_state.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/widget/whish_list_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';
import 'package:localstorage/localstorage.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> with AfterLayoutMixin {
  WishListBloc _bloc = WishListBloc(appRepository: locator.get());
  final local = LocalStorage('ShopApp');
  var wishList = WishList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        'Wish List',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
        color: AppColor.colorPrimary,
      ),
      leading: Container(),
    );
  }

  _blocListener(BuildContext context, WishListState state) async {
    print("State $state");
    if (state is WishListLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is WishListGetDataFailed) {
      EasyLoading.showError(state.msg);
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<WishListBloc, WishListState>(
        listener: _blocListener,
        child: BlocBuilder<WishListBloc, WishListState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is WishListGetDataSuccess) {
                wishList = state.data;
                return Container(
                  padding: const EdgeInsets.all(AppDimen.spacing_2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildWhishLists(wishList),
                      _buildFooterButton(),
                    ],
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }

  Widget _buildWhishLists(WishList data) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (ctx, intdex) {
          return Divider(thickness: .7);
        },
        scrollDirection: Axis.vertical,
        itemCount: data.list.length,
        itemBuilder: (context, index) {
          return WishListWidget(
            checked: true,
            imageUrl: data.list[index].images!.first.imageUrl,
            title: data.list[index].name,
            price: data.list[index].price,
            removeFromWishList: () => _removeFromWishList(data.list[index].id!),
          );
        },
      ),
    );
  }

  _removeFromWishList(String id) {
    setState(() {
      wishList.list.removeWhere((element) => element.id == id);
      _saveToStorage(wishList);
    });
  }

  _saveToStorage(WishList list) {
    local.setItem("WishList", list.toJSON());
  }

  Widget _buildFooterButton() {
    return PrimaryButton(
      title: 'Add to cart',
    );
  }

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getWishListData(local);
  }
}
