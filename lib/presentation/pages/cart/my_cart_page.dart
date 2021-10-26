import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/my_cart_response.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/cart/bloc/my_cart_page_bloc.dart';
import 'package:furniture_shop/presentation/pages/cart/bloc/my_cart_page_state.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/app_text_field.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/tap_outside_to_unfocus.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/presentation/widgets/quantity_view.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> with AfterLayoutMixin {
  TextEditingController _promoCodeController = TextEditingController();

  MyCartPageBloc _bloc = MyCartPageBloc(appRepository: locator.get());

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getMyCart();
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideToUnfocus(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: AppBackButton(imgColor: Colors.black),
      title:
          CustomText('My Cart', fontFamily: FontFamily.gelasio, fontSize: 20.0),
    );
  }

  _blocListener(BuildContext context, MyCartPageState state) async {
    print("State $state");
    if (state is MyCartPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<MyCartPageBloc, MyCartPageState>(
        listener: _blocListener,
        child: BlocBuilder<MyCartPageBloc, MyCartPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is MyCartPageGetDataSuccessState)
              return Stack(
                children: [
                  Container(height: double.infinity, width: double.infinity),
                  _buildContent(state.data),
                  _buildFooterButton(),
                ],
              );

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildFooterButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimen.horizontalSpacing,
            vertical: AppDimen.spacing_3),
        child: Column(
          children: [
            _buildPromoCodeTextField(),
            SizedBox(height: AppDimen.verticalSpacing),
            _buildTotalMoney(),
            SizedBox(height: AppDimen.verticalSpacing),
            PrimaryButton(
              title: 'Check out',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText('Total',
            fontSize: FontSize.BIG, color: AppColor.colorTextLight),
        CustomText('\$70.00',
            fontSize: FontSize.BIG, fontWeight: FontWeight.bold)
      ],
    );
  }

  Widget _buildPromoCodeTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.colorPrimary.withOpacity(0.12),
            spreadRadius: 0.0,
            blurRadius: 20.0,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: AppTextField(
        hintText: 'Enter your promo code',
        suffixIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: AppColor.colorPrimary,
          ),
          width: 50.0,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildContent(List<MyCartResponseData> data) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < data.length; ++i) ..._buildCartList(data[i]),
            SizedBox(height: 200.0)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCartList(MyCartResponseData data) {
    return [
      SizedBox(height: AppDimen.spacing_2),
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
                  image: NetworkImage(data.urlImage ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: AppDimen.horizontalSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    data.productName!,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    '\$' + data.price!.toString(),
                    fontWeight: FontWeight.w700,
                  ),
                  QuantityView(
                    quantity: data.total,
                    onMinusTapped: _onMinusTapped,
                    onPlusTapped: _onPlusTapped,
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.cancel,
                size: 24.0,
                color: AppColor.colorGrey,
              ),
            )
          ],
        ),
      ),
      SizedBox(height: AppDimen.verticalSpacing),
      Divider(
        color: AppColor.indicator,
        height: 1.0,
      )
    ];
  }

  void _onMinusTapped() {}
  void _onPlusTapped() {}
}
