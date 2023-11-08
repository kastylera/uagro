import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../generated/assets.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: const Color(0xffEFEFEF),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(Assets.startBg, fit: BoxFit.fill, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
              Align(alignment: Alignment.center, child: Image.asset(Assets.pictureLogo, width: MediaQuery.of(context).size.width / 1.4)),
            ],
          ),
        ));
  }
}

class AppCircularProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const AppCircularProgressIndicator({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: size ?? 100,
            child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [color ?? Colors.white, color ?? Colors.white],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.transparent)));
  }
}
