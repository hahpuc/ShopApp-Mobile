import 'package:flutter/material.dart';
import 'package:furniture_shop/values/dimens.dart';

import 'base/custom_text.dart';

class QuantityView extends StatefulWidget {
  const QuantityView({
    Key? key,
    this.quantity = 1,
    required this.onMinusTapped,
    required this.onPlusTapped,
  }) : super(key: key);

  final int? quantity;
  final Function onMinusTapped;
  final Function onPlusTapped;

  @override
  _QuantityViewState createState() => _QuantityViewState();
}

class _QuantityViewState extends State<QuantityView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0XFFE0E0E0),
          ),
          child: IconButton(
            onPressed: () {
              widget.onMinusTapped();
            },
            icon: Icon(Icons.remove,
                color: Colors.black, size: AppDimen.icon_size_small),
          ),
        ),
        SizedBox(width: 16.0),
        CustomText(
          widget.quantity.toString(),
          fontSize: 16.0,
          color: Colors.black,
        ),
        SizedBox(width: 16.0),
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0XFFE0E0E0),
          ),
          child: IconButton(
            onPressed: () {
              widget.onPlusTapped();
            },
            icon: Icon(Icons.add,
                color: Colors.black, size: AppDimen.icon_size_small),
          ),
        ),
      ],
    );
  }
}
