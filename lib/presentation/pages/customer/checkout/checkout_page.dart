import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_state.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/card_shadow_widget.dart';
import 'package:furniture_shop/presentation/widgets/horizontal_informations_widget.dart';
import 'package:furniture_shop/presentation/widgets/payment_widget.dart';
import 'package:furniture_shop/presentation/widgets/shipping_information_widget.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

abstract class OnUpadeCheckoutPage {
  void onUpdateShippingAddress();
}

class CheckOutPage extends StatefulWidget {
  final MyCartResponseModel? data;
  final int? totalMoney;

  const CheckOutPage({Key? key, this.data, this.totalMoney}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage>
    with AfterLayoutMixin
    implements OnUpadeCheckoutPage {
  CheckOutPageBloc _bloc = CheckOutPageBloc(appRepository: locator.get());

  ShippingAddressModel? userAddress;
  PAYMENT_METHOD paymentMethod = PAYMENT_METHOD.CASH_ON_DELIVERY;
  int totalMoney = 0;

  @override
  void initState() {
    super.initState();

    totalMoney = widget.totalMoney! + 5;
  }

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getUserAddress();
  }

  _blocListener(BuildContext context, CheckOutPageState state) async {
    print("State $state");
    if (state is CheckOutPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is CheckOutPageGetDataErrorState) {
      EasyLoading.showError(state.msg);
    }

    if (state is CheckOutPageGetUserAddress) {
      setState(() {
        userAddress = state.address;
      });
    }

    if (state is CheckOutPageGetPaymentMethod) {
      setState(() {
        if (state.method == PAYMENT_METHOD.MOMO.toString())
          paymentMethod = PAYMENT_METHOD.MOMO;
        else if (state.method == PAYMENT_METHOD.ZALO.toString())
          paymentMethod = PAYMENT_METHOD.ZALO;

        if (state.method == PAYMENT_METHOD.CASH_ON_DELIVERY.toString())
          paymentMethod = PAYMENT_METHOD.CASH_ON_DELIVERY;
      });
    }

    if (state is CheckOutPageCreateOrderSuccess) {
      Navigator.pushNamed(context, RoutePaths.SUCCESS_PAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<CheckOutPageBloc, CheckOutPageState>(
        listener: _blocListener,
        child: BlocBuilder<CheckOutPageBloc, CheckOutPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is CheckOutPageGetUserAddress ||
                state is CheckOutPageGetPaymentMethod)
              return Scaffold(
                appBar: _buildAppBar(),
                body: _buildBody(),
              );

            return Container();
          },
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText(
        'Check out',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
        color: AppColor.colorPrimary,
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: AppDimen.horizontalSpacing,
          right: AppDimen.horizontalSpacing,
          bottom: AppDimen.spacing_3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailList(),
            _buildFooterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('Shipping Address'),
        _buildDetailShippingAddress(),
        _buildTitle('Payment'),
        __buildDetailPayment(),
      ],
    );
  }

  Widget _buildFooterInfo() {
    return Column(
      children: [
        _buildInfoPrice(),
        _buildButton(),
      ],
    );
  }

  Widget _buildTitle(String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
      child: CustomText(
        title!,
        color: AppColor.colorGrey,
        fontSize: FontSize.BIG,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDetailShippingAddress() {
    return ShippingInformation(
      name: userAddress?.name ?? 'user name',
      phoneNumber: userAddress?.phoneNumber ?? 'phone number',
      address: userAddress?.address ?? 'address',
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.SHIPPING_ADDRESS_PAGE);
      },
    );
  }

  Widget __buildDetailPayment() {
    return PaymentWidget(
      namePayment: _buildNamePayment(),
      icon: _buildLogoPayment(),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.PAYMENT_METHODS);
      },
    );
  }

  String _buildNamePayment() {
    if (paymentMethod == PAYMENT_METHOD.CASH_ON_DELIVERY)
      return AppPayment.cartOnDelivery;
    if (paymentMethod == PAYMENT_METHOD.MOMO) return AppPayment.momo;

    return AppPayment.zalo;
  }

  Image _buildLogoPayment() {
    if (paymentMethod == PAYMENT_METHOD.CASH_ON_DELIVERY)
      return Assets.images.icCashOnDelivery.image();
    if (paymentMethod == PAYMENT_METHOD.MOMO)
      return Assets.images.icMomo.image();

    return Assets.images.icZalo.image();
  }

  Widget _buildInfoPrice() {
    return CardShadowWidget(
      padding: AppDimen.verticalSpacing,
      margin: const EdgeInsets.symmetric(vertical: AppDimen.verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontalInformations(
            title: 'Order',
            value: '${widget.totalMoney} \$',
          ),
          HorizontalInformations(
            title: 'Delivery',
            value: '5 \$',
          ),
          HorizontalInformations(
            title: 'Total',
            value: '${this.totalMoney} \$',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return CustomButton(
      'Submit order',
      padding: EdgeInsets.all(AppDimen.spacing_2),
      sizeStyle: CustomBottomSizeStyle.MATCH_PARENT,
      fontSize: FontSize.BIG,
      onTap: onSubmitButtonTap,
    );
  }

  void onSubmitButtonTap() {
    print("Payment method $paymentMethod");
    print("Total Money $totalMoney");
    print("List Item ${widget.data?.products?.toList()}");
    print("Address ${userAddress?.toJson()}");

    _bloc.checkoutOrder(
        userAddress!, widget.data?.products ?? [], totalMoney, paymentMethod);
  }

  @override
  void onUpdateShippingAddress() {
    print("------> HANDLE UPDATE ADDRESS");
    _bloc.getUserAddress();
  }
}
