import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// class WidgetSize extends StatefulWidget {
//   final Widget child;
//   final Function(Size) onChange;
//   final GlobalKey widgetKey;
//
//   const WidgetSize({
//     Key? key,
//     required this.onChange,
//     required this.child,
//     required this.widgetKey,
//   }) : super(key: key);
//
//   @override
//   _WidgetSizeState createState() => _WidgetSizeState();
// }
//
// class _WidgetSizeState extends State<WidgetSize> {
//   Size? oldSize;
//
//   void postFrameCallback(_) async {
//     var context = widget.widgetKey.currentContext;
//     await Future.delayed(const Duration(milliseconds: 100));
//     if (!mounted || context == null) return;
//
//     var newSize = context.size!;
//     if (oldSize == newSize) return;
//
//     oldSize = newSize;
//     widget.onChange(newSize);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
//     return Container(key: widget.widgetKey, child: widget.child);
//   }
// }

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function(Size) onChange;
  final double oldSize;

  const WidgetSize({Key? key, required this.onChange, required this.child, required this.oldSize}) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  // Size? oldSize;

  void postFrameCallback(_) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted || context == null) return;

    var newSize = context.size!;
    if (widget.oldSize == newSize.height) return;

    // oldSize = newSize;
    widget.onChange(newSize);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(child: widget.child);
  }
}
