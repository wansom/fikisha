// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'Components/sheet_header.dart';
import 'booking_comfirm.dart';
import 'package:fikisha/utils/colors.dart';

buildTripDetails(BuildContext context) {
  Navigator.pop(context);
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 7),
          height: context.screenHeight() / 2.5,
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
                "Delivery Details",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: ColorPath.primarydark,
                ),
              ),
              const Text(
                "Your Delivery information",
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
              tripdetails(
                ImagesAsset.down,
                "Your Current Location",
                "Mbale,Vihiga County",
                "Estimated Distance",
                ImagesAsset.run,
                "Distance: 2.12 km",
              ),
              const YMargin(15),
              const DotWidget(
                dashColor: ColorPath.primaryfield,
                dashHeight: 1.0,
                dashWidth: 2.0,
              ),
              const YMargin(15),
              tripdetails(
                ImagesAsset.locate,
                "Your Destination",
                "Chavakali,Vihiga County",
                "Estimated time",
                ImagesAsset.clock,
                "4 munites 42 secs",
              ),
              const YMargin(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 50,
                  width: context.screenWidth(),
                  decoration: BoxDecoration(
                    color: ColorPath.primarygreen,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("ssss");
                      Navigator.pop(context);
                      showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          clipBehavior: Clip.hardEdge,
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.only(top: 7, bottom: 10),
                              height: context.screenHeight() / 2,
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
                                    "Select a ride",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorPath.primarydark,
                                    ),
                                  ),
                                  const Text(
                                    "🎊 Enjoy 5% discount on 1st three trips",
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
                                  // const RideDetails(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      height: 40,
                                      width: context.screenWidth(),
                                      decoration: BoxDecoration(
                                        color: ColorPath.primarydark,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          buildConfirmTrip(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Book Rider",
                                              style: TextStyle(
                                                color:
                                                    ColorPath.primarywhite,
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
                          });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Confirm",
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
      });
}

Widget tripdetails(
  String icon,
  String locate,
  String location,
  String extimated,
  String eIcon,
  String eDistance,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(icon),
              ],
            ),
            const XMargin(5),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locate,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: ColorPath.primaryblack.withOpacity(0.5),
                  ),
                ),
                const YMargin(10),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF818181),
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              extimated,
              style: const TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFF818181),
              ),
            ),
            const YMargin(2.0),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorPath.primarydark,
                  borderRadius: BorderRadius.circular(7.0)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    eIcon,
                    height: 16,
                    width: 16,
                  ),
                  const XMargin(4),
                  Text(
                    eDistance,
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: ColorPath.primaryfield,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}
