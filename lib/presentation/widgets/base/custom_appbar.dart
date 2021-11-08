import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shop/generated/assets/fonts.gen.dart';
import 'package:furniture_shop/values/font_sizes.dart';

import 'app_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final PreferredSize? bottom;
  List<Widget>? actions = [];

  CustomAppBar({Key? key, this.leading, this.title, this.actions, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0.0,
      centerTitle: true,
      title: _buildTitle(),
      leading: leading ?? AppBackButton(),
      bottom:
          bottom ?? PreferredSize(preferredSize: Size.zero, child: Container()),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  Widget _buildTitle() {
    return DefaultTextStyle(
        style: TextStyle(
            fontSize: FontSize.BIG,
            color: Colors.black,
            fontFamily: FontFamily.poppins),
        child: this.title ?? SizedBox.shrink());
  }
}
