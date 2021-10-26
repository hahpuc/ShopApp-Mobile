import 'package:flutter/material.dart';
import 'package:furniture_shop/generated/assets/assets.gen.dart';
import 'package:furniture_shop/presentation/pages/boarding/dock_button.dart';
import 'package:furniture_shop/values/dimens.dart';
import 'package:furniture_shop/values/font_sizes.dart';

class BoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image(
              image: $AssetsImagesGen().livingRoom,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Positioned(
              top: 200,
              left: 25,
              child: Text(
                "MAKE YOUR",
                style: TextStyle(fontSize: FontSize.BIG_1, color: Colors.white),
              ),
            ),
            Positioned(
              top: 240,
              left: 25,
              child: Text(
                "HOME BEAUTIFUL",
                style: TextStyle(fontSize: FontSize.BIG_2, color: Colors.white),
              ),
            ),
            Positioned(
              top: 320,
              left: 25,
              child: Text(
                "The best simple place where you\n discover most wonderful furnitures\n and make your home beautiful",
                style: TextStyle(fontSize: FontSize.BIG, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 50,
              left: AppDimen.horizontalSpacing,
              child: InkWell(
                child: DockButton(name: "GET START"),
                onTap: () {
                  print("tapped");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
