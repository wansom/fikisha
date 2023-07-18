// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'build_trip_details.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fikisha/utils/colors.dart';

const CameraPosition _kLake =   CameraPosition(
  target: LatLng(8.479879, 4.541814),
  zoom: 24,
);

shareTripInfo(BuildContext context) {
  Navigator.pop(context);
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return const ShareTripInfo();
      });
}

class ShareTripInfo extends StatefulWidget {
  const ShareTripInfo({
    Key? key,
  }) : super(key: key);

  @override
  _ShareTripInfoState createState() => _ShareTripInfoState();
}

class _ShareTripInfoState extends State<ShareTripInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 1.7,
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
              // sheetHeader(),
              const YMargin(15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Share delivery info",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
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
              const YMargin(14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 130,
                  width: context.screenWidth(),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: const GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kLake,
                  ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Trip Route",
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w300,
                        color: ColorPath.offBlack,
                      ),
                    ),
                    const YMargin(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(ImagesAsset.side),
                        const XMargin(10),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Location",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: ColorPath.offBlack,
                              ),
                            ),
                            YMargin(5),
                            Text(
                              "Mbale, Vihiga County",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF818181),
                              ),
                            ),
                            YMargin(30),
                            Text(
                              "Destination",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: ColorPath.offBlack,
                              ),
                            ),
                            YMargin(5),
                            Text(
                              "Chavakali, Vihiga County",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w300,
                                color: ColorPath.offBlack,
                              ),
                            ),
                          ],
                        ),
                      ],
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
              const YMargin(14),
              const YMargin(10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  height: 40,
                  width: context.screenWidth(),
                  decoration: BoxDecoration(
                    color: ColorPath.primarydark,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Share your info",
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
        ],
      ),
    );
  }
}
