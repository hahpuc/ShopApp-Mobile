import 'package:flutter/material.dart';
import 'package:furniture_shop/common/interfaces/iOrder.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/presentation/pages/admin/order_detail_admin/order_detail_admin_page.dart';
import 'package:furniture_shop/presentation/pages/customer/order/fake_data.dart';
import 'package:furniture_shop/presentation/widgets/order_cart.dart';

class NewOrderAdmin extends StatefulWidget {
  const NewOrderAdmin({Key? key}) : super(key: key);

  @override
  State<NewOrderAdmin> createState() => _NewOrderAdminState();
}

class _NewOrderAdminState extends State<NewOrderAdmin>
    implements OnOrderItemListener {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listOrders.length,
        itemBuilder: (BuildContext context, int index) {
          var order = listOrders[index];
          return OrderCard(
            idOrder: order['idOrder'],
            date: order['date'],
            quantity: order['quantity'],
            total: order['total'],
            status: order['status'],
            typeOrder: OrderCardType.Admin,
            listener: this,
          );
        },
      ),
    );
  }

  @override
  void onOrderItemClick(String orderId) {
    print("Navigate to $orderId");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => OrderDetailAdminPage(statusOrder: 1),
      ),
    );
  }
}
