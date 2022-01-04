import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/app_constants.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_state.dart';
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
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage>
    with AfterLayoutMixin
    implements OnUpadeCheckoutPage {
  CheckOutPageBloc _bloc = CheckOutPageBloc(appRepository: locator.get());

  ShippingAddressModel? userAddress;

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
            if (state is CheckOutPageGetUserAddress)
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
      namePayment: AppPayment.zalo,
      icon: Assets.images.icZalo.image(),
    );
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
            value: '70.00 \$',
          ),
          HorizontalInformations(
            title: 'Delivery',
            value: '15.00 \$',
          ),
          HorizontalInformations(
            title: 'Discount',
            value: '-20.00 \$',
          ),
          HorizontalInformations(
            title: 'Total',
            value: '65.00 \$',
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
    );
  }

  @override
  void onUpdateShippingAddress() {
    print("------> HANDLE UPDATE ADDRESS");
    _bloc.getUserAddress();
  }
}
