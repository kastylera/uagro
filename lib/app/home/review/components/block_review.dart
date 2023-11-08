import 'package:agro/model/model_review/model_review.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class BlockReview extends StatelessWidget {
  final ModelReview modelReview;

  const BlockReview({super.key, required this.modelReview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: const Color(0xff000000).withOpacity(0.02), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 0))]),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              readText(text: modelReview.comment.toString(), color: Colors.black, size: 20),
              const SizedBox(height: 15),
              Row(
                children: [
                  RatingStars(
                      value: 5,
                      starBuilder: (index, color) => Icon(Icons.star, color: color, size: 25),
                      starCount: 5,
                      starSize: 25,
                      valueLabelColor: const Color(0xff9b9b9b),
                      valueLabelTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 12.0),
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 0,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      animationDuration: const Duration(seconds: 2),
                      valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: const Color(0xffFEBF2F)),
                  const Spacer(),
                  readText(text: modelReview.date.toString(), color: const Color(0xffA9A9A9), fontWeight: FontWeight.w500, size: 18),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
