import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/widget/whish_list_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_text.dart';
import 'package:furniture_shop/presentation/widgets/primary_button.dart';
import 'package:furniture_shop/values/colors.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

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
        'Wish List',
        fontFamily: FontFamily.gelasio,
        fontSize: FontSize.BIG_1,
        color: AppColor.colorPrimary,
      ),
      leading: Container(),
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

//   List<ListWishList> listItem = [
//     ListWishList(
//       checked: true,
//       imagUrl:
//           'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg',
//       title: 'Desk Gaming',
//       price: 59,
//     ),

// 	ListWishList(
//       checked: false,
//       imagUrl:
//           'https://res.cloudinary.com/dynk5q1io/image/upload/v1636561688/products/Floor%20Lamp/dmhgvhimkjbtsqknuvad.jpg',
//       title: 'Lamp',
//       price: 49,
//     ),

// 	ListWishList(
// 	  checked: false,
// 	  imagUrl:
// 		  'https://res.cloudinary.com/dynk5q1io/image/upload/v1634120101/products/Folding%20Computer%20Desk/l0d5kxt8okip8doh3tos.jpg',
// 	  title: 'Chair',
// 	  price: 129,
// 	),

//   ];

  Widget _buildWhishLists() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (ctx, intdex) {
          return Divider(thickness: .7);
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return WishListWidget(
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
      onPressed: () {
        EasyLoading.showSuccess('Added to cart');
      },
    );
  }
}

//---------
class ListWishList {
  bool? checked;
  String? imagUrl;
  String? title;
  int? price;

  ListWishList({
    this.checked,
    this.imagUrl,
    this.title,
    this.price,
  });
}
