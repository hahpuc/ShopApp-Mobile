import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/tap_outside_to_unfocus.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';

class SuccessPage extends StatefulWidget {
  SuccessPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SuccessPageState();
  }
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              Assets.images.bgCircleBrown.path,
              height: 250.0,
            ),
          ),
          TapOutsideToUnfocus(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                child: _buildBody(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(AppDimen.spacing_2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.images.icSuccess.path,
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: AppDimen.spacing_2),
                CustomText(
                  'SUCCESS!',
                  color: AppColor.colorBlack,
                  fontFamily: FontFamily.gelasio,
                  fontSize: 24.0,
                ),
                SizedBox(height: AppDimen.spacing_2),
                CustomText(
                  'Your order will be delivered soon.\nThank you for choosing our app!',
                  maxLine: 2,
                  align: TextAlign.center,
                  color: AppColor.colorGrey,
                )
              ],
            ),
          ),
          SizedBox(height: AppDimen.spacing_large),
          PrimaryButton(
            title: 'Return Home',
            onPressed: _onBackHomeTapped,
          )
        ],
      ),
    );
  }

  void _onBackHomeTapped() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
