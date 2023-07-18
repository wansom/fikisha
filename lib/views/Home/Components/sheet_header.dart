import 'package:flutter/material.dart';
import 'package:fikisha/utils/colors.dart';

Widget sheetHeader() {
  return Container(
      width: 80,
      height: 2.875,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(80)),
        color: ColorPath.primaryColor.withOpacity(0.5),
      ));
}
