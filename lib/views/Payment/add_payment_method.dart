// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Payment/payment.dart';
import 'package:fikisha/utils/colors.dart';

class AddPaymethod extends StatefulWidget {
  const AddPaymethod({Key? key}) : super(key: key);

  @override
  State<AddPaymethod> createState() => _AddPaymethodState();
}

class _AddPaymethodState extends State<AddPaymethod> {
  String? payment = "cash";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Add Payment Method"),
      ),
      body: FadeInUp(
        duration: const Duration(milliseconds: 2000),
        child: Column(
          children: [
            const YMargin(30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Text(
                    "How would you like to pay for your trips!",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: ColorPath.primarydark,
                    ),
                  ),
                ],
              ),
            ),
            const YMargin(30),
            Container(
              height: 85,
              width: context.screenWidth(),
              decoration: BoxDecoration(
                color: payment == "cash"
                    ? ColorPath.primarydark
                    : ColorPath.secondaryColor.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const XMargin(20),
                      SvgPicture.asset(
                        ImagesAsset.money1,
                        color: payment == "cash"
                            ? ColorPath.secondaryColor
                            : ColorPath.primarydark,
                      ),
                      const XMargin(10),
                      Text(
                        "Pay with Cash",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: payment != "cash"
                              ? ColorPath.primarydark
                              : ColorPath.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: ColorPath.secondaryColor,
                        value: "cash",
                        onChanged: (value) {
                          setState(() {
                            payment = value.toString();
                          });
                        },
                        groupValue: payment,
                      ),
                      const XMargin(20),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 85,
              width: context.screenWidth(),
              decoration: BoxDecoration(
                color: payment != "cash"
                    ? ColorPath.primarydark
                    : ColorPath.secondaryColor.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const XMargin(20),
                      SvgPicture.asset(
                        ImagesAsset.card,
                        color: payment != "cash"
                            ? ColorPath.secondaryColor
                            : ColorPath.primarydark,
                      ),
                      const XMargin(10),
                      Text(
                        "Pay with Debit or Credit Card",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: payment != "cash"
                              ? ColorPath.secondaryColor
                              : ColorPath.primarydark,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: ColorPath.secondaryColor,
                        value: "card",
                        onChanged: (value) {
                          setState(() {
                            payment = value.toString();
                          });
                        },
                        groupValue: payment,
                      ),
                      const XMargin(20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
