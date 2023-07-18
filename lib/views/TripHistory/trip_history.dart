import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/views/Home/build_trip_details.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/views/Payment/payment.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';

class TripHistory extends StatelessWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition kLake = CameraPosition(
      target: LatLng(-3.4000, 38.3833),
      zoom: 30,
    );

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Your Delivery History"),
      ),
      body: Column(
        children: [
          const YMargin(40),
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 130,
                width: context.screenWidth(),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: const GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: kLake,
                ),
              ),
            ),
          ),
          const YMargin(20),
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivery Details",
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
                            "Kwara Mall,  Mbale",
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
                            "Kwara Mall,  Chavakali",
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
          ),
          const YMargin(20),
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            child: const DotWidget(
              dashColor: ColorPath.primaryfield,
              dashHeight: 1.0,
              dashWidth: 2.0,
            ),
          ),
          const YMargin(20),
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: Padding(
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
                    onTap: () {},
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
          ),
          const YMargin(14),
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: const DotWidget(
              dashColor: ColorPath.primaryfield,
              dashHeight: 1.0,
              dashWidth: 2.0,
            ),
          ),
          const YMargin(14),
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Trip Cost",
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.w300,
                      color: ColorPath.offBlack,
                    ),
                  ),
                  const YMargin(10),
                  Row(
                    children: [
                      const Text(
                        "Ksh 1,100",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: ColorPath.primarydark,
                        ),
                      ),
                      const XMargin(8.0),
                      Container(
                        width: 47,
                        height: 18,
                        decoration: BoxDecoration(
                            color: ColorPath.primaryfield.withOpacity(0.47),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                color: ColorPath.primaryColor
                                  ..withOpacity(0.5))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImagesAsset.cash),
                            const XMargin(3.0),
                            const Text(
                              "Cash",
                              style: TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w300,
                                color: ColorPath.offBlack,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const YMargin(14),
          FadeInUp(
            duration: const Duration(milliseconds: 2000),
            child: const DotWidget(
              dashColor: ColorPath.primaryfield,
              dashHeight: 1.0,
              dashWidth: 2.0,
            ),
          ),
          const YMargin(14),
          FadeInUp(
            duration: const Duration(milliseconds: 2000),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Make Complaint",
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.w300,
                      color: ColorPath.offBlack,
                    ),
                  ),
                  const YMargin(10),
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImagesAsset.rider))),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Report Driver",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: ColorPath.primarydark,
                            ),
                          ),
                          YMargin(8.0),
                          Text(
                            "Any Issue with the Delivery? File a complaint now!",
                            style: TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.w300,
                              color: ColorPath.primarydark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const YMargin(14),
          FadeInUp(
            duration: const Duration(milliseconds: 2200),
            child: const DotWidget(
              dashColor: ColorPath.primaryfield,
              dashHeight: 1.0,
              dashWidth: 2.0,
            ),
          ),
          const Spacer(),
          FadeInUp(
            duration: const Duration(milliseconds: 2300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 50,
                width: context.screenWidth(),
                decoration: BoxDecoration(
                  color: ColorPath.secondarygrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Share Fikisha Information",
                        style: TextStyle(
                          color: ColorPath.secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ).ripple(() {}),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
