import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget readText(
        {required String text,
        double? size,
        double? heightText,
        int? maxLine,
        Color? color,
        TextAlign? align,
        FontWeight? fontWeight,
        bool? bold,
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
                style: GoogleFonts.getFont('Inter',
                    fontWeight: fontWeight ?? FontWeight.w400,
                    fontSize: size ?? 16,
                    color: color ?? Colors.white,
                    height: heightText ,
                    decoration: underline ? TextDecoration.underline : TextDecoration.none,
                    decorationColor: decorationColor ?? Colors.white))
          ],
        ),
      ),
    );
