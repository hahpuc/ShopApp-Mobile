import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/order/fake_data.dart';
import 'package:furniture_shop/presentation/pages/order/widgets/order_cart.dart';

class AllOrderWidget extends StatelessWidget {
  const AllOrderWidget({Key? key}) : super(key: key);

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
        );
      },
    );
  }
}
