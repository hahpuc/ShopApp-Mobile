import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/profile/profile_bloc.dart';
import 'package:furniture_shop/presentation/pages/profile/profile_state.dart';
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
          child: SvgPicture.asset(Assets.images.icLogout.path,
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
              Assets.images.nancy.path,
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
    List<String> listOptions = [
      "My Orders",
      "Shipping Addresses",
      "Payment Method",
      "Settings"
    ];
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppDimen.spacing_2, vertical: AppDimen.spacing_large),
      child: ListView.builder(
          itemCount: listOptions.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.spacing_3, vertical: AppDimen.spacing_3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        listOptions[index],
                        fontSize: FontSize.BIG,
                        fontWeight: FontWeight.bold,
                        color: AppColor.colorPrimary,
                      ),
                      CustomText(
                        "Already have 10 orders",
                        fontSize: FontSize.SMALL_1,
                        color: AppColor.colorTextLight,
                      )
                    ],
                  ),
                  SvgPicture.asset(Assets.images.icNavigation.path)
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.colorWhite,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.colorBoxShadowProfile.withOpacity(0.2),
                    blurRadius: 40,
                    offset: Offset(0, 7), // Shadow position
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
