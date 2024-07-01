import 'package:flutter/material.dart';

class BTransparentScalableButton extends StatefulWidget {
  final Widget child;
  final Function() onPressed;
  final Function()? onLongPress;
  final ScaleFormat scale;

  const BTransparentScalableButton({super.key, required this.child, required this.onPressed, this.onLongPress, required this.scale});

  @override
  State<BTransparentScalableButton> createState() => _BTransparentScalableButtonState();
}

class _BTransparentScalableButtonState extends State<BTransparentScalableButton> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  late AnimationStatusListener listener;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 50), vsync: this);
    animation = Tween<double>(
            begin: 1,
            end: widget.scale == ScaleFormat.big
                ? 0.86
                : widget.scale == ScaleFormat.small
                    ? 0.94
                    : 1)
        .animate(controller)
      ..addListener(() => setState(() {}));

    listener = (status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        controller.removeStatusListener(listener);
      }
    };

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        key: widget.key,
        onLongPress: widget.onLongPress,
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => controller.forward(),
        onTapUp: (_) {
          widget.onPressed();

          if (controller.isAnimating) {
            controller.addStatusListener(listener);
          } else {
            controller.reverse();
          }
        },
        onTapCancel: () => controller.reverse(),
        child: Transform.scale(
          scale: animation.value,
          child: widget.child,
        ),
      );
}

enum ScaleFormat { small, big, none }
