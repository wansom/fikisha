// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'Components/sheet_header.dart';
import 'build_trip_details.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/utils/colors.dart';
import 'chat_with_driver.dart';
import 'drivers_details.dart';
import 'enjoy_ride.dart';

buildBookingDetails(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return const BookingDetials();
      });
}

class BookingDetials extends StatefulWidget {
  const BookingDetials({
    Key? key,
  }) : super(key: key);

  @override
  _BookingDetialsState createState() => _BookingDetialsState();
}

class _BookingDetialsState extends State<BookingDetials> {
  @override
  void initState() {
    setState(() {
      Future.delayed(const Duration(seconds: 5), () {
        buildEnjoyRide(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 2.0,
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
            "Booking Details",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: ColorPath.primarydark,
            ),
          ),
          const Text(
            "Your Rider is making this way  to pickup delivery!",
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w300,
              color: ColorPath.offBlack,
            ),
          ),
          const YMargin(14),
          const DotWidget(
            dashColor: ColorPath.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "RIDERS INFORMATION",
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w300,
                        color: ColorPath.offBlack,
                      ),
                    ),
                    YMargin(10),
                    Text(
                      "Ochieng Warren",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: ColorPath.primarydark,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Honda Cycle 2010 |",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: ColorPath.primarydark,
                          ),
                        ),
                        Text(
                          "237183AR",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: ColorPath.primarydark,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Black Color",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: ColorPath.primarydark,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    driversDetail(context);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImagesAsset.driverpic))),
                  ),
                ),
              ],
            ),
          ),
          const YMargin(14),
          const DotWidget(
            dashColor: ColorPath.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "AVERAGE RIDER RATING",
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w300,
                        color: ColorPath.offBlack,
                      ),
                    ),
                    YMargin(5.0),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 13,
                          color: ColorPath.primarydark,
                        ),
                        Icon(
                          Icons.star,
                          size: 13,
                          color: ColorPath.primarydark,
                        ),
                        Icon(
                          Icons.star,
                          size: 13,
                          color: ColorPath.primarydark,
                        ),
                        Icon(
                          Icons.star,
                          size: 13,
                          color: ColorPath.primarydark,
                        ),
                        Icon(
                          Icons.star,
                          size: 13,
                          color: ColorPath.primaryColor,
                        ),
                        Text(
                          "4.7",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: ColorPath.primarydark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: ColorPath.primarydark,
                          borderRadius: BorderRadius.all(
                            Radius.circular(11),
                          )),
                      child: SvgPicture.asset(ImagesAsset.message),
                    ).ripple(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatWithDriver(),
                          ));
                    }),
                    const XMargin(5.0),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: ColorPath.primarydark,
                          borderRadius: BorderRadius.all(
                            Radius.circular(11),
                          )),
                      child: SvgPicture.asset(ImagesAsset.call,
                          height: 12, width: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          const YMargin(10.0),
          const DotWidget(
            dashColor: ColorPath.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagesAsset.time,
                height: 12,
                width: 12,
                color: const Color(0xFF999393),
              ),
              const XMargin(5),
              const Text(
                "Rider Arrives In 5 munites",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF999393),
                ),
              ),
            ],
          ),
          const YMargin(10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              height: 40,
              width: context.screenWidth(),
              decoration: BoxDecoration(
                color: ColorPath.primaryred,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Canel Ride",
                      style: TextStyle(
                        color: ColorPath.primarywhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
