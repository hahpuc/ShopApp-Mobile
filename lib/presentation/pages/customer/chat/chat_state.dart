import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/chat_response.dart';

class ChatPageState extends BaseState {}

class ChatPageLoadingState extends ChatPageState {}

class ChatPageGetDataSuccessState extends ChatPageState {
  List<ChatResponseData>? data;
  ChatPageGetDataSuccessState(this.data);
}

class ChatPageGetDataFailState extends ChatPageState {}
