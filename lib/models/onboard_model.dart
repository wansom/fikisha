import 'package:flutter/material.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/images_path.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: ImagesAsset.parking,
    text: "Enjoy affordable deliveraries",
    desc:
        "We have many riders available for you\n to pick your orders and make deliveries \non time.",
    bg: ColorPath.primarywhite,
    button: const Color(0xFF4756DF),
  ),
  OnboardModel(
    img: ImagesAsset.money,
    text: "Enjoy affordable deliveraries",
    desc:
        "We have many riders available for you\n to pick your orders and make deliveries \non time.",
    bg: const Color(0xFF4756DF),
    button: ColorPath.primarywhite,
  ),
  OnboardModel(
    img: ImagesAsset.accomodation,
    text: "Enjoy affordable deliveraries",
    desc:
        "We have many riders available for you\n to pick your orders and make deliveries \non time.",
    bg: ColorPath.primarywhite,
    button: const Color(0xFF4756DF),
  ),
];
