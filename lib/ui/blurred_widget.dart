import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BlurredWidget extends StatelessWidget {
  final Widget child;
  final double blurSigma;

  const BlurredWidget({super.key, required this.child, this.blurSigma = 1.0});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [child, Positioned.fill(child: _buildBlurOverlay())],
      ),
    );
  }

  Widget _buildBlurOverlay() {
    return IgnorePointer(
      child: BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma), child: Container(color: Colors.transparent)),
    );
  }
}
