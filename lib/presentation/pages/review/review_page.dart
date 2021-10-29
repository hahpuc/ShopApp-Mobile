import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/review/rating_product.dart';
import 'package:furniture_shop/presentation/pages/review/user_review.dart';
import 'package:furniture_shop/presentation/widgets/base/custom_appbar.dart';
import 'package:furniture_shop/values/dimens.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(title: Text("Rating & Review")),
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
      child: Column(
        children: [
          RatingProduct(
            imageUrl:
                'https://assets.weimgs.com/weimgs/rk/images/wcm/products/202141/0038/book-nook-armchair-c.jpg',
            name: "Chair",
            rating: 4.6,
            reviewCount: 24,
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.black.withOpacity(0.3),
          ),
          SizedBox(
            height: 10,
          ),
          UserReview(
            name: 'Võ Minh Đôn',
            date: DateTime.now(),
            rate: 2,
            comment:
                'Võ Minh Đôn, Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn Võ Minh Đôn.',
          )
        ],
      ),
    ),
  );
}
