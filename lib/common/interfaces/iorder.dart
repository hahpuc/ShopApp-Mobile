import 'package:furniture_shop/data/model/response/order_response.dart';

abstract class OnOrderItemListener {
  void onOrderItemClick(OrderDataModel order);
}
