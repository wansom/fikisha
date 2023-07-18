// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'Components/sheet_header.dart';
import 'package:fikisha/utils/colors.dart';

vehicleDetails(BuildContext context) {
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return const VehiclesDetails();
      });
}

class VehiclesDetails extends StatefulWidget {
  const VehiclesDetails({
    Key? key,
  }) : super(key: key);

  @override
  _VehiclesDetailsState createState() => _VehiclesDetailsState();
}

class _VehiclesDetailsState extends State<VehiclesDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
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
          const YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Image(
              width: 110,
              height: 66,
              image: AssetImage(ImagesAsset.regular),
            ),
          ),
          const YMargin(14),
          const Text(
            "Rydr Regular",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: ColorPath.primarydark,
            ),
          ),
          const YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: ColorPath.primarydark,
                    borderRadius: BorderRadius.circular(7.0)),
                child: const Center(
                  child: Text(
                    "Classic, everyday rides to the mall, your office, the restaurant for dinner \nwith friends, or to your Primary Place of Assignment!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.w400,
                        color: ColorPath.secondaryColor),
                  ),
                )),
          ),
          const YMargin(14),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fare",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                      ),
                    ),
                    Text(
                      "Ksh12,000",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                      ),
                    ),
                  ],
                ),
                YMargin(14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wait Time",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                      ),
                    ),
                    Text(
                      "Ksh10/Min",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                      ),
                    ),
                  ],
                ),
                YMargin(14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Seat",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                      ),
                    ),
                    Text(
                      "4",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const YMargin(40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "The price estimation can change if actual tools/surcharges differ from estimation. If the journey changes, the price will be based on rates provided.",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: ColorPath.primarydark),
            ),
          ),
        ],
      ),
    );
  }
}
