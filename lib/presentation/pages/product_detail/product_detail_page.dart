import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/product_detail/widget/product_picture_widget.dart';
import 'package:furniture_shop/presentation/widgets/base/app_back_button.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leading: AppBackButton(imgColor: Colors.black),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        ProfilePictureList(
          pageController: _pageController,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(height: 100, color: Colors.red),
        )
      ],
    );
  }
}
