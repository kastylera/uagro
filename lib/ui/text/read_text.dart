import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget readText(
        {required String text,
        double? size,
        double? heightText,
        int? maxLine,
        Color? color,
        TextAlign? align,
        TextStyle? style,
        FontWeight? fontWeight,
        EdgeInsetsGeometry? padding,
        Color? decorationColor,
        bool underline = false}) =>
    Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: RichText(
        textAlign: align ?? TextAlign.start,
        maxLines: maxLine,
        overflow: maxLine != null ? TextOverflow.ellipsis : TextOverflow.clip,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: text,
                style: style ?? GoogleFonts.getFont('Nunito',
                    fontWeight: fontWeight ?? FontWeight.w400,
                    fontSize: size ?? 16,
                    color: color ?? AppColors.black,
                    height: heightText ,
                    decoration: underline ? TextDecoration.underline : TextDecoration.none,
                    decorationColor: decorationColor ?? AppColors.black))
          ],
        ),
      ),
    );
