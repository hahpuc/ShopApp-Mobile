import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/whish_list/widget/whish_list_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/dimens.dart';

class WhishListPage extends StatelessWidget {
  const WhishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: Text('My cart'),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(AppDimen.spacing_2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWhishLists(),
          _buildFooterButton(),
        ],
      ),
    );
  }

  Widget _buildWhishLists() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (ctx, intdex) {
          return Divider(thickness: .7);
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return WhishListWidget(
            checked: true,
            imageUrl:
                'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg',
            title: 'Gaming',
            price: 50,
          );
        },
      ),
    );
  }

  Widget _buildFooterButton() {
    return PrimaryButton(
      title: 'Add to cart',
    );
  }
}
