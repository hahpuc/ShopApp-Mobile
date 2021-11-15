import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/common/mixins/loading_view.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/payment_methods/enum.dart';
import 'package:furniture_shop/presentation/pages/payment_methods/payment_method_bloc.dart';
import 'package:furniture_shop/presentation/pages/payment_methods/payment_method_state.dart';
import 'package:furniture_shop/presentation/pages/payment_methods/widget/method_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodPageState();
  }
}

class _PaymentMethodPageState extends State<PaymentMethodPage>
    with LoadingViewMixin {
  PaymentMethodPageBloc _bloc =
      PaymentMethodPageBloc(appRepository: locator.get());

  @override
  void initState() {
    super.initState();
    _bloc.loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
        title: CustomText(
      'Payment Methods',
      fontFamily: FontFamily.gelasio,
      fontSize: FontSize.BIG,
    ));
  }

  _blocListener(BuildContext context, PaymentMethodPageState state) async {
    if (state is PaymentMethodPageLoadingState) {
      showLoading();
    } else {
      dismissLoading();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<PaymentMethodPageBloc, PaymentMethodPageState>(
        listener: _blocListener,
        child: BlocBuilder<PaymentMethodPageBloc, PaymentMethodPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is PaymentMethodPageGetDataSuccessState) {
              PAYMENT_METHOD? _groupValue = _bloc.paymentMethod;
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
                  child: Column(
                    children: [
                      PaymentMethodWidget<PAYMENT_METHOD>(
                          paymentMethodIcon: Assets.images.icMomo.path,
                          paymentMethodName: 'Momo',
                          value: PAYMENT_METHOD.MOMO,
                          groupValue: _groupValue,
                          text: 'Use as default payment method',
                          onChanged: _valueChangedHandler()),
                      PaymentMethodWidget<PAYMENT_METHOD>(
                          paymentMethodIcon: Assets.images.icZalo.path,
                          paymentMethodName: 'Zalo',
                          value: PAYMENT_METHOD.ZALO,
                          groupValue: _groupValue,
                          text: 'Use as default payment method',
                          onChanged: _valueChangedHandler()),
                      PaymentMethodWidget<PAYMENT_METHOD>(
                          paymentMethodIcon:
                              Assets.images.icCashOnDelivery.path,
                          paymentMethodName: 'Cash On Delivery',
                          value: PAYMENT_METHOD.CASH_ON_DELIVERY,
                          groupValue: _groupValue,
                          text: 'Use as default payment method',
                          onChanged: _valueChangedHandler())
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  ValueChanged<PAYMENT_METHOD?> _valueChangedHandler() {
    return (value) {
      _bloc.changePaymentMethod(value);
    };
  }
}
