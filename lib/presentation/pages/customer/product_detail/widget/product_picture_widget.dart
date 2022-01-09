import 'package:flutter/material.dart';
import 'package:furniture_shop/data/model/response/product_detail/product_detail_response.dart';
import 'package:furniture_shop/presentation/widgets/indicator_view.dart';
import 'package:furniture_shop/values/dimens.dart';

class ProductPicture extends StatelessWidget {
  const ProductPicture({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
            image: NetworkImage(imageUrl ?? ''), fit: BoxFit.cover),
      ),
    );
  }
}

class ProfilePictureList extends StatelessWidget {
  const ProfilePictureList({
    Key? key,
    required this.pageController,
    this.images,
  }) : super(key: key);

  final PageController pageController;
  final List<ImageModel>? images;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              for (int i = 0; i < images!.length; ++i)
                ProductPicture(imageUrl: images?[i].imageUrl),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.spacing_2),
                child: IndicatorView(
                  color: Colors.black,
                  pageController: pageController,
                  count: images!.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
