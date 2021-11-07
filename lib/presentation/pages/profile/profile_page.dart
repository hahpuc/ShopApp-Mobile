import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/profile/profile_bloc.dart';
import 'package:furniture_shop/presentation/pages/profile/profile_state.dart';
import 'package:furniture_shop/presentation/pages/profile/widget/option_button_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> with AfterLayoutMixin {
  ProfilePageBloc _bloc = ProfilePageBloc(appRepository: locator.get());
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
      title: CustomText(
        "PROFILE",
        fontFamily: FontFamily.gelasio,
      ),
      leading: SizedBox(),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
          onPressed: () {},
          icon: SvgPicture.asset(Assets.images.icLogout.path,
              color: AppColor.colorTextLight),
        ),
      ],
    );
  }

  _blocListener(BuildContext context, ProfilePageState state) async {
    // print("State $state");
    if (state is ProfilePageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<ProfilePageBloc, ProfilePageState>(
        listener: _blocListener,
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ProfilePageGetDataSuccessState) {
              return Column(
                children: [_buildInformation(state.data), _buildOptions()],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildInformation(UserResponseData data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 50,
            child: Image.asset(
              Assets.images.imgNancy.path,
              width: AppDimen.avatarRadius,
              height: AppDimen.avatarRadius,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(data.name ?? "",
                    fontSize: FontSize.BIG, fontFamily: FontFamily.gelasio),
                CustomText(data.phoneNumber ?? "",
                    fontSize: FontSize.MEDIUM, color: AppColor.colorTextLight)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppDimen.spacing_2,
                vertical: AppDimen.spacing_large),
            child: Column(
              children: [
                OptionButton(
                  option: "My Orders",
                  detail: "Already have 10 orders",
                  onPress: _onMyOrderTapped,
                ),
                OptionButton(
                    option: "Shipping Addresses",
                    detail: "03 Address",
                    onPress: null),
                OptionButton(
                  option: "Payment Method",
                  detail: "Zalopay, Momo,...",
                  onPress: null,
                ),
                OptionButton(
                  option: "Settings",
                  detail: null,
                  onPress: null,
                )
              ],
            )));
  }

  void _onMyOrderTapped() {
    Navigator.pushNamed(context, RoutePaths.MY_ORDER);
  }
}
