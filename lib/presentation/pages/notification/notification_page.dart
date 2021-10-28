import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/notification_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_bloc.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_state.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage>
    with AfterLayoutMixin {
  NotificationPageBloc _bloc =
      NotificationPageBloc(appRepository: locator.get());
  List<bool> _isSelected = [];

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        "Notification",
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
      leading: SizedBox(),
    );
  }

  _blocListener(BuildContext context, NotificationPageState state) async {
    // print("State $state");
    if (state is NotificationPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<NotificationPageBloc, NotificationPageState>(
        listener: _blocListener,
        child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is NotificationPageGetDataSuccessState) {
              return _buildListNotification(state.data);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildListNotification(List<NotificationResponseData> data) {
    return Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                color: data[index].seen == false
                    ? AppColor.colorNotSeen
                    : Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.spacing_3,
                    vertical: AppDimen.spacing_2),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: AppDimen.spacing_1),
                      child: Image.asset(
                        // data[index].image.toString(),
                        Assets.images.desk.path,
                        width: AppDimen.imageSquare,
                        height: AppDimen.imageSquare,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data[index].title.toString(),
                            color: AppColor.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.SMALL_1,
                          ),
                          CustomText(
                            data[index].message.toString(),
                            color: AppColor.colorTextLight,
                            fontSize: FontSize.SMALL_2,
                            overflow: TextOverflow.visible,
                            align: TextAlign.justify,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
