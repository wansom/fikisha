// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:fikisha/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'Components/sheet_header.dart';
import 'booking_details.dart';
import 'build_trip_details.dart';
import 'drivers_details.dart';

buildConfirmTrip(BuildContext context) {
  Navigator.pop(context);
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return const BookingComfirm();
      });
}

class BookingComfirm extends StatefulWidget {
  const BookingComfirm({
    Key? key,
  }) : super(key: key);

  @override
  _BookingComfirmState createState() => _BookingComfirmState();
}

class _BookingComfirmState extends State<BookingComfirm> {
  @override
  void initState() {
    setState(() {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pop(context);
        buildBookingDetails(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 3,
      width: context.screenWidth(),
      decoration: const BoxDecoration(
        color: ColorPath.primarywhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          sheetHeader(),
          const YMargin(15),
          const Text(
            "Delivery confimed",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: ColorPath.primarydark,
            ),
          ),
          const Text(
            "Rider has accepted your booking. Finding you a driver",
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w300,
              color: ColorPath.offBlack,
            ),
          ),
          const YMargin(10),
          const DotWidget(
            dashColor: ColorPath.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(10),
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(ImagesAsset.ripple),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        driversDetail(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImagesAsset.driverpic))),
                      ),
                    ),
                    const YMargin(8.0),
                    const Text(
                      "Your Rider",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: ColorPath.primarydark,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: ColorPath.primarydark,
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            )),
                        child: SvgPicture.asset(ImagesAsset.cancelride),
                      ),
                      const YMargin(8.0),
                      const Text(
                        "Cancel Delivery",
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: ColorPath.primarydark,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
