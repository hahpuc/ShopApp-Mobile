import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/chat_response.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/chat_state.dart';
import 'package:furniture_shop/presentation/pages/customer/demo/demo_state.dart';

class ChatPageBloc extends BlocBase<ChatPageState> {
  final AppRepository appRepository;

  ChatPageBloc({required this.appRepository}) : super(ChatPageState());

  Future<void> loadData() async {
    emit(ChatPageLoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(ChatPageGetDataSuccessState(demeChatMessages));
  }
}

List<ChatResponseData> demeChatMessages = [
  ChatResponseData(
    text: "Hi Sajol,",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: false,
  ),
  ChatResponseData(
    text: "Hello, How are you?",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    imageUrl:
        "https://image.thanhnien.vn/w2048/Uploaded/2021/wsxrxqeiod/2021_01_24/nc-01_ecbm.jpg",
    messageType: ChatMessageType.IMAGE,
    messageStatus: MessageStatus.SEEN,
    isSender: false,
  ),
  ChatResponseData(
    imageUrl:
        "https://image.thanhnien.vn/w2048/Uploaded/2021/wsxrxqeiod/2021_01_24/nc-01_ecbm.jpg",
    messageType: ChatMessageType.IMAGE,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    text: "My lover",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    text: "This looks great man!!",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: false,
  ),
  ChatResponseData(
    text: "Glad you like it",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    text: "My lover",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    text: "This looks great man!!",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: false,
  ),
  ChatResponseData(
    text: "Glad you like it",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    text: "My lover",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
  ChatResponseData(
    text: "This looks great man!!",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: false,
  ),
  ChatResponseData(
    text: "Glad you like it",
    messageType: ChatMessageType.TEXT,
    messageStatus: MessageStatus.SEEN,
    isSender: true,
  ),
];
