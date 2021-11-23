import 'package:furniture_shop/data/model/response/base/base_response.dart';

enum ChatMessageType { TEXT, IMAGE }
enum MessageStatus { NOT_SENT, NOT_SEEN, SEEN }

class ChatResponse extends BaseResponseData<ChatResponseData> {
  @override
  ChatResponseData parseData(data) {
    // TODO: implement parseData
    throw UnimplementedError();
  }
}

class ChatResponseData {
  final String? text;
  final String? imageUrl;
  final ChatMessageType? messageType;
  final MessageStatus? messageStatus;
  final bool? isSender;

  ChatResponseData({
    this.text = '',
    this.imageUrl = 'https://via.placeholder.com/200',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });

  factory ChatResponseData.fromMap(Map<String, dynamic> map) {
    return ChatResponseData(
      text: map['text'] as String,
      imageUrl: map['imageUrl'] as String,
      isSender: map['isSender'] as bool,
      messageStatus: map['messageStatus'] as MessageStatus,
      messageType: map['messageType'] as ChatMessageType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "text": this.text,
      "imageUrl": this.imageUrl,
      "isSender": this.isSender,
      'messageStatus': this.messageStatus,
      'messageType': this.messageType
    };
  }
}
