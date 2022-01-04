import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/common/mixins/after_layout.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/shipping_addresses/address.dart';
import 'package:furniture_shop/presentation/pages/customer/shipping_addresses/bloc/shipping_addresses_bloc.dart';
import 'package:furniture_shop/presentation/pages/customer/shipping_addresses/bloc/shipping_addresses_state.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/base/footer_scroll_view.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class ShippingAddressesPage extends StatefulWidget {
  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage>
    with AfterLayoutMixin {
  ShippingAddressPageBloc _bloc =
      ShippingAddressPageBloc(appRepository: locator.get());

  List<ShippingAddressModel> address = [];

  ShippingAddressModel? currentAddress;

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: CustomText(
        'Shipping Addresses',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
          onPressed: () {
            _addShippingAddressesTapped(context);
          },
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _addShippingAddressesTapped(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.ADD_SHIPPING_ADDRESSES);
  }

  _blocListener(BuildContext context, ShippingAddressPageState state) async {
    print("State $state");
    if (state is ShippingAddressPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }

    if (state is ShippingAddressPageGetDataErrorState) {
      EasyLoading.showError(state.msg);
    }

    if (state is ShippingAddressPageGetDataSuccessState) {
      setState(() {
        address = state.data;
      });
    }

    if (state is SetAddressDefaultSuccessState) {
      _bloc.getUserAddress();
    }
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<ShippingAddressPageBloc, ShippingAddressPageState>(
        listener: _blocListener,
        child: BlocBuilder<ShippingAddressPageBloc, ShippingAddressPageState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ShippingAddressPageGetDataSuccessState ||
                state is SetAddressDefaultSuccessState ||
                state is SetAddressToLocalSuccessState) {
              return FooterScrollView(
                body: _buildListAddresses(),
                footer: _buildFooter(),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50.0,
        child: PrimaryButton(
          title: 'Save Address',
          onPressed: () {
            _bloc.setDefaultAddressToLocal(currentAddress);
          },
        ),
      ),
    );
  }

  Widget _buildListAddresses() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...mockAddress()],
      ),
    );
  }

  List<Widget> mockAddress() {
    return [
      for (int i = 0; i < address.length; ++i)
        Address(
          name: address[i].name,
          phoneNumber: address[i].phoneNumber,
          address: address[i].address,
          isDefaultAddress: address[i].isDefault,
          onTap: () {
            currentAddress = address[i];
            _bloc.setDefaultAddress(address[i].id ?? '');
          },
        )
    ];
  }
}
