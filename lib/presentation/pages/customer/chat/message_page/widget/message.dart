import 'package:flutter/material.dart';
import 'package:furniture_shop/data/model/response/chat_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/message_page/widget/image_message.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/message_page/widget/text_message.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';

class Message extends StatelessWidget {
  final ChatResponseData message;
  final bool isLastIndex;

  Message({
    Key? key,
    required this.isLastIndex,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatResponseData message) {
      switch (message.messageType) {
        case ChatMessageType.TEXT:
          return TextMessage(message: message);
        case ChatMessageType.IMAGE:
          return ImageMessage(message: message);
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
      child: Row(
        mainAxisAlignment:
            message.isSender! ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isSender!) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: Assets.images.user2,
            ),
            SizedBox(width: AppDimen.spacing_1 / 2),
          ],
          messageContaint(message),
          if (message.isSender!)
            MessageStatusDot(
              status: message.messageStatus,
              isLastIndex: isLastIndex,
            )
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;
  bool isLastIndex;

  MessageStatusDot({Key? key, this.status, this.isLastIndex = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.NOT_SEEN:
          return AppColor.colorBlack;
        case MessageStatus.SEEN:
          return Colors.transparent;
        default:
          return Colors.transparent;
      }
    }

    if (status == MessageStatus.NOT_SEEN) {
      return Container(
        margin: EdgeInsets.only(left: AppDimen.spacing_1 / 2),
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: dotColor(status!),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.done,
          size: AppDimen.spacing_1,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
    } else if (isLastIndex == true) {
      return Container(
        margin: EdgeInsets.only(left: AppDimen.spacing_1),
        child: CircleAvatar(
          radius: AppDimen.spacing_1,
          backgroundImage: Assets.images.user2,
        ),
      );
    } else
      return Container(
        height: 12,
        width: 12,
      );
  }
}
