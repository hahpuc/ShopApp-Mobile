import 'package:flutter/material.dart';
import 'package:furniture_shop/common/interfaces/iOrder.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/presentation/pages/order/fake_data.dart';
import 'package:furniture_shop/presentation/widgets/order_cart.dart';

class AllOrderWidget extends StatefulWidget {
  const AllOrderWidget({Key? key}) : super(key: key);

  @override
  State<AllOrderWidget> createState() => _AllOrderWidgetState();
}

class _AllOrderWidgetState extends State<AllOrderWidget>
    implements OnOrderItemListener {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: listOrders.length,
      itemBuilder: (BuildContext context, int index) {
        var order = listOrders[index];
        return OrderCard(
          idOrder: order['idOrder'],
          date: order['date'],
          quantity: order['quantity'],
          total: order['total'],
          status: order['status'],
          listener: this,
        );
      },
    );
  }

  @override
  void onOrderItemClick(String orderId) {
    print("Navigate to $orderId");
    Navigator.pushNamed(context, RoutePaths.ORDER_DETAIL);
  }
}
