import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:furniture_shop/data/model/response/order_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/bloc/update_order_bloc.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/bloc/update_order_state.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';
import 'package:furniture_shop/presentation/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/horizontal_informations_widget.dart';
import 'package:furniture_shop/presentation/widgets/payment_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/presentation/widgets/shipping_information_widget.dart';
import 'package:furniture_shop/presentation/widgets/time_line_view.dart';
import 'package:furniture_shop/utils/datetime_utils.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';
import 'package:intl/intl.dart';

class OrderDetailAdminPage extends StatefulWidget {
  final OrderDataModel? orderData;

  const OrderDetailAdminPage({Key? key, this.orderData}) : super(key: key);

  @override
  _OrderDetailAdminPageState createState() => new _OrderDetailAdminPageState();
}

class _OrderDetailAdminPageState extends State<OrderDetailAdminPage> {
  UpdateOrderBloc _bloc = UpdateOrderBloc(appRepository: locator.get());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: CustomText(
          'Order Detail',
          fontFamily: FontFamily.gelasio,
          fontSize: FontSize.BIG,
        ),
        leading: AppBackButton(imgColor: Colors.black),
      ),
      body: _buildBody(),
    );
  }

  _blocListener(BuildContext context, UpdateOrderState state) async {
    print("State $state");
    if (state is UpdateOrderLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is UpdateOrderSuccess) {
      EasyLoading.showSuccess('Update order success');
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<UpdateOrderBloc, UpdateOrderState>(
        listener: _blocListener,
        child: BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
          builder: (context, state) {
            return FooterScrollView(
              body: _buildContent(),
              footer: _buildFooter(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooter() {
    var buttonTitle = 'Ship this order';
    if (widget.orderData?.statusCode == 1)
      buttonTitle = 'Ship this order';
    else if (widget.orderData?.statusCode == 3)
      buttonTitle = 'Complete this order';

    if (widget.orderData?.statusCode != 4)
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50.0,
          child: PrimaryButton(
            title: buttonTitle,
            onPressed: () {
              _bloc.updateOrder();
            },
          ),
        ),
      );
    else
      return Container();
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildShippingInformation(),
          ..._buildDeliveryAddress(),
          ..._buildListItem(),
          ..._buildPaymentInfo(),
          ..._buildInfoPrice(),
        ],
      ),
    );
  }

  List<Widget> _buildShippingInformation() {
    return [
      Row(
        children: [
          SvgPicture.asset(
            Assets.images.icDelivery.path,
            height: 32.0,
            width: 32.0,
          ),
          SizedBox(width: AppDimen.horizontalSpacing),
          CustomText('Shipping information')
        ],
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      TimeLiveView(
        orderData: widget.orderData,
        statusOrder: widget.orderData?.statusCode ?? 1,
        statusList: widget.orderData?.statusList ?? [],
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      Divider(color: AppColor.indicator, height: 1.0),
      SizedBox(height: AppDimen.verticalSpacing),
    ];
  }

  List<Widget> _buildDeliveryAddress() {
    return [
      Row(
        children: [
          Icon(
            Icons.location_on,
            size: 32.0,
          ),
          SizedBox(width: AppDimen.horizontalSpacing),
          CustomText('Delivery address'),
        ],
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      ShippingInformation(
        name: widget.orderData?.name ?? '',
        phoneNumber: widget.orderData?.phoneNumber ?? '',
        address: widget.orderData?.shippingAddress ?? '',
      ),
    ];
  }

  List<Widget> _buildListItem() {
    final formatterPrice = NumberFormat.decimalPattern();
    return [
      SizedBox(height: AppDimen.verticalSpacing),

      for (var item in widget.orderData!.items!) ..._buildItem(item),

      SizedBox(height: AppDimen.verticalSpacing),

      // Total price
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText('Order total', fontWeight: FontWeight.w600),
          CustomText(
              '\$' + formatterPrice.format(widget.orderData?.totalMoney ?? 0),
              fontWeight: FontWeight.w700),
        ],
      )
    ];
  }

  List<Widget> _buildItem(ProductModel item) {
    final formatterPrice = NumberFormat.decimalPattern();
    return [
      SizedBox(height: AppDimen.verticalSpacing),
      Container(
        height: 100.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      item.productId?.images?.first.imageUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: AppDimen.horizontalSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    item.productId?.name ?? '',
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    '\$' + formatterPrice.format(item.productId?.price ?? 0),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      Divider(
        color: AppColor.colorGreyLight,
        height: 1.0,
      )
    ];
  }

  List<Widget> _buildPaymentInfo() {
    return [
      SizedBox(height: AppDimen.verticalSpacing),
      CustomText('Payment',
          fontSize: FontSize.BIG, fontWeight: FontWeight.bold),
      SizedBox(height: AppDimen.verticalSpacing),
      Container(
        height: 75.0,
        child: _buildPaymentWidget(),
      ),
    ];
  }

  Widget _buildPaymentWidget() {
    if (widget.orderData?.paymentMethod == 2)
      return PaymentWidget(
        namePayment: AppPayment.momo,
        icon: Assets.images.icMomo.image(),
      );

    if (widget.orderData?.paymentMethod == 3)
      return PaymentWidget(
        namePayment: AppPayment.zalo,
        icon: Assets.images.icZalo.image(),
      );

    return PaymentWidget(
      namePayment: AppPayment.cartOnDelivery,
      icon: Assets.images.icCashOnDelivery.image(),
    );
  }

  List<Widget> _buildInfoPrice() {
    return [
      SizedBox(height: AppDimen.verticalSpacing),
      CardShadowWidget(
        padding: AppDimen.verticalSpacing,
        margin: const EdgeInsets.symmetric(vertical: AppDimen.verticalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.orderData?.orderCode != null
                ? HorizontalInformations(
                    title: 'Order ID',
                    value: widget.orderData!.orderCode,
                    fontWeight: FontWeight.bold,
                  )
                : Container(),
            widget.orderData?.orderTime != null
                ? HorizontalInformations(
                    title: 'Order Time',
                    value: DateTimeUtils.convertToDateTimeString(
                        widget.orderData!.orderTime!),
                  )
                : Container(),
            widget.orderData?.paymentTime != null
                ? HorizontalInformations(
                    title: 'Pay Time',
                    value: DateTimeUtils.convertToDateTimeString(
                        widget.orderData!.paymentTime!),
                  )
                : Container(),
            widget.orderData?.shipTime != null
                ? HorizontalInformations(
                    title: 'To Ship',
                    value: DateTimeUtils.convertToDateTimeString(
                        widget.orderData!.shipTime!),
                  )
                : Container(),
            widget.orderData?.completedTime != null
                ? HorizontalInformations(
                    title: 'Completed',
                    value: DateTimeUtils.convertToDateTimeString(
                        widget.orderData!.completedTime!),
                  )
                : Container(),
          ],
        ),
      )
    ];
  }
}
