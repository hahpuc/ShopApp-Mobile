import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/common/mixins/loading_view.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/notification_response.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_bloc.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_state.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage>
    with LoadingViewMixin {
  NotificationPageBloc _bloc =
      NotificationPageBloc(appRepository: locator.get());

  var _pagingController =
      PagingController<int, NotificationResponseData>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      print("Add Page Request Listner: $pageKey");
      _bloc.loadData(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<NotificationPageBloc, NotificationPageState>(
        listener: _blocListener,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
      ),
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
    print("State $state");
    if (state is NotificationPageLoadingState) {
      showLoading();
    } else {
      dismissLoading();
    }
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: BlocListener<NotificationPageBloc, NotificationPageState>(
        listenWhen: (previous, current) =>
            previous != current &&
            current is NotificationPageGetDataSuccessState,
        listener: (context, state) {
          if (state is NotificationPageGetDataSuccessState) {
            final isLastPage = state.page == state.totalPages;
            if (isLastPage) {
              _pagingController.appendLastPage(state.data!);
            } else {
              _pagingController.appendPage(state.data!, state.page! + 1);
            }
          }
        },
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
              noItemsFoundIndicatorBuilder: (context) => Container(),
              itemBuilder: (BuildContext context, dynamic item, int index) {
                return _buildItem(context, item, index);
              }),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              indent: 16.0,
              endIndent: 16.0,
              color: Color(0XFFF0F0F0),
              thickness: 0.3,
              height: 0,
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, NotificationResponseData notification, int index) {
    return InkWell(
      onTap: _onItemTap,
      child: Container(
        color:
            notification.seen == false ? AppColor.colorNotSeen : Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: AppDimen.spacing_2, vertical: AppDimen.spacing_2),
        child: Row(
          children: [
            Container(
              height: 70.0,
              width: 70.0,
              margin: EdgeInsets.only(right: AppDimen.spacing_1),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(notification.image!),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimen.spacing_1),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    notification.title.toString(),
                    color: AppColor.colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.SMALL_1,
                  ),
                  CustomText(
                    notification.message.toString(),
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
      ),
    );
  }

  void _onItemTap() {
    print("Item tapped");
  }
}
