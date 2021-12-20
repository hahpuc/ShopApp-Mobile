import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/widgets/cancel_order_admin.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/widgets/complete_order_admin.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/widgets/new_order_admin.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/widgets/ship_order_admin.dart';

import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

List<Widget> _listWidgets = [
  NewOrderAdmin(),
  ShipOrderAdmin(),
  CompleteOrderAdmin(),
  CancelOrderAdmin(),
];

class OrderAdminPage extends StatefulWidget {
  const OrderAdminPage({Key? key}) : super(key: key);

  @override
  State<OrderAdminPage> createState() => _OrderAdminPageState();
}

class _OrderAdminPageState extends State<OrderAdminPage> {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _listWidgets.length,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: Container(),
      title: CustomText(
        'My Order',
        fontSize: FontSize.BIG_1,
        fontFamily: FontFamily.gelasio,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.images.icSearch.path,
            width: AppDimen.icon_size,
            height: AppDimen.icon_size,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size(0, 25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBar(
            unselectedLabelColor: AppColor.colorGrey,
            labelColor: Colors.red,
            indicatorColor: AppColor.colorPrimary,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: [
              _buildTabText('New Orders'),
              _buildTabText('To Ship'),
              _buildTabText('Completed'),
              _buildTabText('Cancelled'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabText(String title) {
    return CustomText(title);
  }

  Widget _buildBody() {
    return TabBarView(
      children: _listWidgets,
    );
  }
}
