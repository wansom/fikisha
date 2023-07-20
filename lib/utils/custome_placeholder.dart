// ignore_for_file: avoid_print

import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/build_trip_details.dart';
import 'package:fikisha/views/Home/schedule_trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../views/Home/Components/sheet_header.dart';
import 'images_path.dart';

class CustomPlaceHolder extends StatefulWidget {
  const CustomPlaceHolder({Key? key}) : super(key: key);

  @override
  State<CustomPlaceHolder> createState() => _CustomPlaceHolderState();
}

class _CustomPlaceHolderState extends State<CustomPlaceHolder> {
  final locationController = TextEditingController();
  late GoogleMapController controller;
  final currentLocController = TextEditingController();
  final destinationController = TextEditingController();

    void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

  void searchLocations() async {
    final query = locationController.text;
    if (query.isEmpty) {
      return;
    }
    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) {
        return;
      }
      final lng = LatLng(locations.first.latitude, locations.first.longitude);
      controller.animateCamera(CameraUpdate.newLatLngZoom(lng, 15));
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 55,
        width: MediaQuery.of(context).size.width,        
        child:TextField(
              controller: locationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Where to ?',
                    suffixIcon: IconButton(
                      onPressed: searchLocations,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    prefixIcon: Icon(
                        Icons.drive_eta_rounded,
                        color: ColorPath.primaryColor.withOpacity(0.3),
                        size: 30,
                      ),),
            ), 
      ).ripple(() {
        showModalBottomSheet(
            isDismissible: true,
            isScrollControlled: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.only(top: 7),
                height: context.screenHeight() - 118,
                width: context.screenWidth(),
                decoration: const BoxDecoration(
                  color: ColorPath.primarywhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: pickLocation(context),
              );
            });
      }
      ),
    );
  }

  Widget pickLocation(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            sheetHeader(),
            const YMargin(40),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SvgPicture.asset(ImagesAsset.side),
                  const SizedBox(width: 20,),
                  Column(
                    children: [
                      SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: TextField(
                    controller: currentLocController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        prefixIcon: const Icon(Icons.car_repair),
                        hintText: 'Current location',
                        ),
                     onSubmitted: (_) {
                          buildTripDetails(context);
                        },
                  ),
        ),                     
                      const YMargin(10.0),
                       SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: TextField(
                    controller: destinationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        prefixIcon: const Icon(Icons.location_on),
                        hintText: 'Destination',
                        ),
                     onSubmitted: (_) {
                          buildTripDetails(context);
                        },
                  ),
        ), 
        const YMargin(30.0),
        ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPath.primarydark,
          minimumSize: const Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
          onPressed: () {
            scheduleTrip(context);
          }, 
          child: const Text('Schedule delivery'),
          )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(ImagesAsset.stopwatch),
            const YMargin(10),
            const Text(
              "Consider the time and don’t keep the rider waiting.",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorPath.primarydark,
              ),
            ),
            const YMargin(10),
            const Text(
              "You will be charged an additional Ksh50 for every minute you \nkeep the rider waiting",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999393),
              ),
            ),
            const YMargin(15),
            Container(
              height: 70,
              width: context.screenWidth(),
              decoration: const BoxDecoration(
                color: ColorPath.primarydark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImagesAsset.globe),
                    const XMargin(5.0),
                    const Text(
                      "Search on Map",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorPath.primarywhite,
                      ),
                    )
                  ]),
            ),
          ],
        )
      ],
    );
  }
}