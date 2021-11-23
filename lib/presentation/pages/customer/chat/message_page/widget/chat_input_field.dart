import 'package:flutter/material.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimen.spacing_1,
        vertical: AppDimen.spacing_1 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: AppColor.colorPrimary.withOpacity(0.2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.spacing_1 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: AppColor.colorPrimary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type message",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_1),
                child: IconButton(
                  icon: Icon(Icons.send, color: AppColor.colorPrimary),
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}
