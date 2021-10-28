import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/notification_response.dart';

class NotificationPageState extends BaseState {}

class NotificationPageLoadingState extends NotificationPageState {}

class NotificationPageGetDataSuccessState extends NotificationPageState {
  final List<NotificationResponseData> data;
  NotificationPageGetDataSuccessState(this.data);
}

class NotificationPageGetDataFailState extends NotificationPageState {}
