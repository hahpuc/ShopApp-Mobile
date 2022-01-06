import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/interfaces/iOrder.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/order_response.dart';
import 'package:furniture_shop/presentation/pages/customer/order/bloc/order_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/order/bloc/order_state.dart';
import 'package:furniture_shop/presentation/widgets/order_cart.dart';

class CompletedOrderWidget extends StatefulWidget {
  const CompletedOrderWidget({Key? key}) : super(key: key);

  @override
  State<CompletedOrderWidget> createState() => _CompletedOrderWidgetState();
}

class _CompletedOrderWidgetState extends State<CompletedOrderWidget>
    implements OnOrderItemListener {
  OrderPageBloc _bloc = OrderPageBloc(appRepository: locator.get());

  List<OrderDataModel> items = [];

  @override
  void initState() {
    super.initState();

    _bloc.getOrderByStatus(4);
  }

  _blocListener(BuildContext context, OrderPageState state) async {
    print("State $state");
    if (state is OrderPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is OrderPageSuccessState) {
      print("Order list ${state.data.toList()}");

      setState(() {
        items = state.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<OrderPageBloc, OrderPageState>(
          listener: _blocListener,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.getOrderByStatus(4);
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          var order = items[index];
          return OrderCard(
            orderId: order.id,
            orderCode: order.orderCode,
            date: order.orderTime,
            quantity: order.items?.length ?? 0,
            total: order.totalMoney,
            status: order.statusCode,
            orderDetailData: order,
            listener: this,
          );
        },
      ),
    );
  }

  @override
  void onOrderItemClick(OrderDataModel order) {
    print("Navigate to ${order.toJson()}");
    Navigator.pushNamed(context, RoutePaths.ORDER_DETAIL, arguments: order);
  }
}
