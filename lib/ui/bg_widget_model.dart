// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../generated/assets.dart';
// import '../../../ui/buttons/b_transparent_scalable_button.dart';
// import '../../../ui/text/read_text.dart';
//
// class BgWidgetModel extends StatelessWidget {
//   final Widget child;
//   final String header;
//   final bool backActive, reverse;
//   final double? height;
//   final String? iconEnd;
//   final Function()? onPressedEnd, onPressedCancel;
//
//   const BgWidgetModel(
//       {Key? key,
//       required this.child,
//       required this.header,
//       this.backActive = true,
//       this.height,
//       this.reverse = false,
//       this.iconEnd,
//       this.onPressedEnd,
//       this.onPressedCancel})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext c) {
//     return  SizedBox(
//       height: height ?? MediaQuery.of(c).size.height,
//       child: Material(
//         child: Container(
//           height: MediaQuery.of(c).size.height / 1.15,
//           decoration: const BoxDecoration(color: Colors.black),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 14, bottom: 10),
//                 child: Container(
//                   width: 90,
//                   height: 5,
//                   decoration: BoxDecoration(color: const Color(0xffDEDEDE), borderRadius: BorderRadius.circular(15)),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     if (reverse) ...[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 7),
//                         child: BTransparentScalableButton(
//                             onPressed: onPressedCancel ?? () => Navigator.pop(c),
//                             scale: ScaleFormat.small,
//                             child: SvgPicture.asset(Assets.componentsCancel, width: 20, color: const Color(0xffDEDEDE))),
//                       )
//                     ] else ...[
//                       if (iconEnd != null) ...[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 7),
//                           child: BTransparentScalableButton(
//                               onPressed: onPressedEnd ?? () {}, scale: ScaleFormat.small, child: SvgPicture.asset(iconEnd!, width: 20, color: const Color(0xffDEDEDE))),
//                         )
//                       ]
//                     ],
//                     Expanded(
//                         child: Center(
//                             child: readText(
//                                 text: header,
//                                 color: Colors.white,
//                                 size: 27,
//                                 fontWeight: FontWeight.w700,
//                                 padding: EdgeInsets.only(
//                                     left: backActive && !reverse && iconEnd == null ? 20 : 0, right: backActive && reverse && iconEnd == null ? 20 : 0)))),
//                     if (!reverse) ...[
//                       if (backActive) ...[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 7),
//                           child: BTransparentScalableButton(
//                               onPressed: onPressedCancel ?? () => Navigator.pop(c),
//                               scale: ScaleFormat.small,
//                               child: SvgPicture.asset(Assets.componentsCancel, width: 20, color: const Color(0xffDEDEDE))),
//                         )
//                       ],
//                     ] else ...[
//                       if (iconEnd != null) ...[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 7),
//                           child: BTransparentScalableButton(
//                               onPressed: onPressedEnd ?? () {}, scale: ScaleFormat.small, child: SvgPicture.asset(iconEnd!, width: 20, color: const Color(0xffDEDEDE))),
//                         )
//                       ]
//                     ]
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 child: Container(width: MediaQuery.of(c).size.width, height: .3, color: const Color(0xffDEDEDE)),
//               ),
//               Expanded(child: child)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
