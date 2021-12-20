import 'package:flutter/material.dart';
import 'package:furniture_shop/common/mixins/loading_view.dart';
import 'package:furniture_shop/data/model/response/chat_response.dart';
import 'package:furniture_shop/presentation/widgets/pin_zoom_image.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';

class ImageMessage extends StatelessWidget with LoadingViewMixin {
  ChatResponseData? message;

  ImageMessage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (message?.imageUrl != null) {
      return InkWell(
        onTap: () {
          showDialog(
              barrierColor: AppColor.colorBlack.withOpacity(0.9),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.2,
                  ),
                  child: PinchZoomImage(
                    imagePath: message!.imageUrl!,
                  ),
                );
              });
        },
        child: Container(
          width: size.width * 0.4,
          height: size.width * 0.4,
          decoration: BoxDecoration(
              color: AppColor.colorGrey,
              borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimen.spacing_2),
            child: Image.network(
              message!.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: size.width * 0.4,
        height: size.width * 0.4,
        decoration: BoxDecoration(
            color: AppColor.colorGrey,
            borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 1.0,
          ),
        ),
      );
    }
  }
}
