import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';

Widget authHeader(BuildContext context) {
  return FadeInDown(
    duration: Duration(milliseconds: 1500),
    child: Column(
      children: [
        Center(
          child: Container(
            alignment: Alignment.center,
            width: 105,
            height: 33,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(ImagesAsset.logosm),
              ),
            ),
          ),
        ),
        YMargin(30),
        Container(
          width: context.screenWidth(),
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    ImagesAsset.authimage1,
                  ))),
        ),
      ],
    ),
  );
}
