import 'package:flutter/material.dart';
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
        image:
            DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover),
      ),
    );
  }
}

class ProfilePictureList extends StatelessWidget {
  const ProfilePictureList({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              ProductPicture(
                imageUrl:
                    'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg',
              ),
              ProductPicture(
                imageUrl:
                    'http://res.cloudinary.com/dynk5q1io/image/upload/v1634120354/products/Gaming%20Table/z36qyy9awic0eltow6qi.jpg',
              ),
              Container(color: Colors.blue),
              Container(color: Colors.pink),
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
                  count: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
