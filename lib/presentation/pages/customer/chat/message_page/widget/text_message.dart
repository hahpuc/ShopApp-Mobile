import 'package:flutter/material.dart';
import 'package:furniture_shop/data/model/response/chat_response.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';

class TextMessage extends StatelessWidget {
  final ChatResponseData message;

  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimen.spacing_2 * 0.75,
        vertical: AppDimen.spacing_2 / 2,
      ),
      decoration: BoxDecoration(
        color: AppColor.colorGrey.withOpacity(message.isSender! ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: CustomText(
        message.text!,
        color: message.isSender! ? AppColor.colorWhite : AppColor.colorBlack,
        fontFamily: FontFamily.nutinoSans,
      ),
    );
  }
}
