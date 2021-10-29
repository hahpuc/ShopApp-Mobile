import 'package:flutter/material.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class UserReview extends StatelessWidget {
  final String? name;
  final DateTime? date;
  final int? rate;
  final String? comment;

  const UserReview({Key? key, this.name, this.date, this.rate, this.comment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimen.radiusNormal),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimen.horizontalSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${this.name}',
                  style: TextStyle(
                      fontSize: FontSize.SMALL, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${this.date}',
                  style: TextStyle(
                      fontSize: FontSize.SMALL_1,
                      color: Colors.black.withOpacity(0.5)),
                )
              ],
            ),
            _buildStar(),
            SizedBox(
              height: 10,
            ),
            Text(
              '${this.comment}',
              style: TextStyle(fontSize: FontSize.SMALL),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar() {
    return Row(
      children: getStar(this.rate ?? 0),
    );
  }

  List<Widget> getStar(int rate) {
    List<Icon> _list = [];
    for (int i = 0; i < rate; i++) {
      _list.add(
        Icon(
          IconData(0xe5f9, fontFamily: 'MaterialIcons'),
          color: Colors.yellow[600],
        ),
      );
    }
    for (int i = 0; i < 5 - rate; i++) {
      _list.add(
        Icon(
          IconData(0xe5f9, fontFamily: 'MaterialIcons'),
          color: Colors.grey[300],
        ),
      );
    }
    return _list;
  }
}
