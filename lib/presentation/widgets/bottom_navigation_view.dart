import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/values/dimens.dart';

class BottomTabType {
  static const HOME = 0;
  static const MYCART = 1;
  static const NOTIFICATION = 2;
  static const PROFILE = 3;
}

typedef OnBottomNavigationListener(int index, bool isDoubleTab);

class BottomNavigationView extends StatefulWidget {
  final OnBottomNavigationListener listener;

  BottomNavigationView({required this.listener});

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationViewState();
  }
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final double _opacityUnselected = 0.4;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //   decoration: BoxDecoration(color: Colors.red),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              _clickTab(0);
            },
            onDoubleTap: () {
              _clickTab(0, isDoubleTab: true);
            },
            child: Container(
              child: _currentIndex == 0
                  ? Assets.images.icHomeSelected.image(
                      width: AppDimen.bottomNavigationIcon,
                      height: AppDimen.bottomNavigationIcon)
                  : Opacity(
                      opacity: _opacityUnselected,
                      child: Assets.images.icHome.image(
                          width: AppDimen.bottomNavigationIcon,
                          height: AppDimen.bottomNavigationIcon)),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              _clickTab(1);
            },
            onDoubleTap: () {
              _clickTab(1, isDoubleTab: true);
            },
            child: Container(
                child: _currentIndex == 1
                    ? Assets.images.icWishListSelected.image(
                        width: AppDimen.bottomNavigationIcon,
                        height: AppDimen.bottomNavigationIcon)
                    : Opacity(
                        opacity: _opacityUnselected,
                        child: Assets.images.icWishList.image(
                            width: AppDimen.bottomNavigationIcon,
                            height: AppDimen.bottomNavigationIcon),
                      )),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              _clickTab(2);
            },
            onDoubleTap: () {
              _clickTab(2, isDoubleTab: true);
            },
            child: Container(
              child: _currentIndex == 2
                  ? Assets.images.icNotificationSelected.image(
                      width: AppDimen.bottomNavigationIcon,
                      height: AppDimen.bottomNavigationIcon)
                  : Opacity(
                      opacity: _opacityUnselected,
                      child: Assets.images.icNotification.image(
                          width: AppDimen.bottomNavigationIcon,
                          height: AppDimen.bottomNavigationIcon)),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              _clickTab(3);
            },
            onDoubleTap: () {
              _clickTab(3, isDoubleTab: true);
            },
            child: Container(
              child: _currentIndex == 3
                  ? Assets.images.icProfileSelected.image(
                      width: AppDimen.bottomNavigationIcon,
                      height: AppDimen.bottomNavigationIcon)
                  : Opacity(
                      opacity: _opacityUnselected,
                      child: Assets.images.icProfile.image(
                          width: AppDimen.bottomNavigationIcon,
                          height: AppDimen.bottomNavigationIcon)),
            ),
          )),
        ],
      ),
    );
  }

  void _clickTab(int index, {bool isDoubleTab = false}) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      widget.listener(_currentIndex, isDoubleTab);
    }
  }
}
