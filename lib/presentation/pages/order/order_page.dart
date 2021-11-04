import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/order/widgets/all_order_widget.dart';
import 'package:furniture_shop/presentation/pages/order/widgets/cancel_order_widget.dart';
import 'package:furniture_shop/presentation/pages/order/widgets/completed_order_widget.dart';
import 'package:furniture_shop/presentation/pages/order/widgets/pay_order_widget.dart';
import 'package:furniture_shop/presentation/pages/order/widgets/ship_order_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/font_sizes.dart';

List<Widget> _listWidgets = [
  AllOrderWidget(),
  PayOrderWidget(),
  ShipOrderWidget(),
  CompletedOrderWidget(),
  CancelOrderWidget(),
];

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        'My Order',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
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
              _buildTabText('All'),
              _buildTabText('To Pay'),
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
