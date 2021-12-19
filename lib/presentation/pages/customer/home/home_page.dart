import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/admin/home_tab/home_tab_admin_page.dart';
import 'package:furniture_shop/presentation/pages/customer/home_tab/home_tab_page.dart';
import 'package:furniture_shop/presentation/pages/customer/notification/notification_page.dart';
import 'package:furniture_shop/presentation/pages/customer/profile/profile_page.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/whish_list_page.dart';
import 'package:furniture_shop/presentation/widgets/bottom_navigation_view.dart';
import 'package:furniture_shop/values/colors.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _tabs = [
    // HomeAdminTabPage(),
    HomeTabPage(),
    WishListPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _tabs,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.colorDropShadow.withOpacity(0.20),
                spreadRadius: 0.0,
                blurRadius: 50.0,
                offset: Offset(0.0, -2.0), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationView(listener: _clickTab),
        ),
      ),
    );
  }

  void _clickTab(int index, bool isDoubleTab) {
    // final _isLoggedIn = false;
    // if (!_isLoggedIn && index == 4) {
    //   Navigator.of(context).pushNamed(RoutePaths.LOGIN_PAGE);
    // } else {
    _tabController.animateTo(index);
    // }
  }
}
