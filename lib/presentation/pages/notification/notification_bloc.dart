import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/fake_data.dart';
import 'package:furniture_shop/data/model/response/notification_response.dart';
import 'package:furniture_shop/data/model/response/product_detail_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_state.dart';

class NotificationPageBloc extends BlocBase<NotificationPageState> {
  final AppRepository appRepository;

  NotificationPageBloc({required this.appRepository})
      : super(NotificationPageState());

  Future<void> getCategoriesData() async {
    emit(NotificationPageLoadingState());

    List<NotificationResponseData> notification = List.of(notificationData);
    if (notification != null) {
      emit(NotificationPageGetDataSuccessState(notification));
    } else
      emit(NotificationPageGetDataFailState());
  }
}
