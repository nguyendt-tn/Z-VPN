import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:nz_vpn/core/constants/color_constants.dart';
import 'package:nz_vpn/core/constants/dismension_constants.dart';
import 'package:nz_vpn/core/helpers/asset_helper.dart';
import 'package:nz_vpn/core/helpers/image_helper.dart';
import 'package:nz_vpn/core/representation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirectIntroScreen();
  }

  void redirectIntroScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: ImageHelper.loadFromAsset(
                  AssetHelper.imageBackgroundSplash,
                  fit: BoxFit.fitWidth)),
          SizedBox(
            height: kDefaultMargin,
          ),
          LoadingAnimationWidget.dotsTriangle(
            color: ColorPalette.primaryColor,
            size: kDefaultLoadingSize,
          ),
        ],
      ),
    );
  }
}
