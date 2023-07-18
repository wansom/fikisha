// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'build_trip_details.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/colors.dart';

driversDetail(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return const DriversDetail();
      });
}

class DriversDetail extends StatefulWidget {
  const DriversDetail({
    Key? key,
  }) : super(key: key);

  @override
  _DriversDetailState createState() => _DriversDetailState();
}

class _DriversDetailState extends State<DriversDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 1.1,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 20),
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: ColorPath.primarywhite, shape: BoxShape.circle),
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image(
                  width: 110,
                  height: 110,
                  image: AssetImage(ImagesAsset.driverpic),
                ),
              ),
              const YMargin(14),
              const Text(
                "Ochieng Warren",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: ColorPath.primarydark,
                ),
              ),
              const YMargin(15),
              const DotWidget(
                dashColor: ColorPath.primaryfield,
                dashHeight: 1.0,
                dashWidth: 2.0,
              ),
              const YMargin(15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Details",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: ColorPath.offBlack,
                      ),
                    ),
                    YMargin(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Completed Trips",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(5),
                            Text(
                              "214",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: ColorPath.primarydark,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Trip Orders",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(5),
                            Text(
                              "278",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: ColorPath.primarydark,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "AVERAGE DRIVER RATING",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(5),
                            Row(
                              children: [
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
                                  ],
                                ),
                                Text(
                                  "4.7",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: ColorPath.primarydark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const YMargin(14),
              const DotWidget(
                dashColor: ColorPath.primaryfield,
                dashHeight: 1.0,
                dashWidth: 2.0,
              ),
              const YMargin(14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bike Details",
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: ColorPath.offBlack,
                          ),
                        ),
                        YMargin(9),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bike Model",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(3),
                            Text(
                              "Honda Cycle 2010",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: ColorPath.primarydark,
                              ),
                            ),
                          ],
                        ),
                        YMargin(8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bike Number",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(3),
                            Text(
                              "237183AR",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: ColorPath.primarydark,
                              ),
                            ),
                          ],
                        ),
                        YMargin(8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bike Color",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(3),
                            Text(
                              "Black Color",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: ColorPath.primarydark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Contact Driver",
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: ColorPath.offBlack,
                          ),
                        ),
                        const YMargin(9),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                  color: ColorPath.primarydark,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(11),
                                  )),
                              child: SvgPicture.asset(ImagesAsset.message),
                            ),
                            const XMargin(5.0),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                  color: ColorPath.primarydark,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(11),
                                  )),
                              child: SvgPicture.asset(ImagesAsset.call,
                                  height: 12, width: 12),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const YMargin(14),
              const DotWidget(
                dashColor: ColorPath.primaryfield,
                dashHeight: 1.0,
                dashWidth: 2.0,
              ),
              const YMargin(14),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bike Images",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: ColorPath.offBlack,
                      ),
                    ),
                  ],
                ),
              ),
              const YMargin(14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image(
                  width: 338,
                  height: 182,
                  image: AssetImage(ImagesAsset.bike1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
