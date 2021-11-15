import 'package:furniture_shop/bloc/base/base_state.dart';
import 'package:furniture_shop/data/model/response/notification_response.dart';

class NotificationPageState extends BaseState {}

class NotificationPageLoadingState extends NotificationPageState {}

class NotificationPageGetDataSuccessState extends NotificationPageState {
  int? page;
  int? totalPages;
  final List<NotificationResponseData>? data;

  NotificationPageGetDataSuccessState({this.page, this.totalPages, this.data});
}

class NotificationPageGetDataFailState extends NotificationPageState {}
