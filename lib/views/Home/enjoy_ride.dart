// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/views/Home/share_trip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Components/sheet_header.dart';
// import 'arrived_destination.dart';
import 'build_trip_details.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/colors.dart';

buildEnjoyRide(BuildContext context,String destinationLocation, String sourceLocation, String totalCost) {
  Navigator.pop(context);
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return EnjoyRide(
          sourceLocation: sourceLocation, 
          destinationLocation: destinationLocation, 
          totalCost: totalCost
        );
      });
}

class EnjoyRide extends StatefulWidget {
  final String sourceLocation;
  final String  destinationLocation;
  final String totalCost;
  const EnjoyRide({
    Key? key, 
    required this.sourceLocation, 
    required this.destinationLocation, 
    required this.totalCost,
  }) : super(key: key);

  @override
  _EnjoyRideState createState() => _EnjoyRideState();
}

class _EnjoyRideState extends State<EnjoyRide> {
  @override
  void initState() {
    setState(() {
      Future.delayed(const Duration(seconds: 8), () {
        // arrivedDestination(context);
      });
    });
    super.initState();
  }

// CollectionReference deliveryHistoryCollection = FirebaseFirestore.instance.collection('fikisha_delivery_history');
Stream<Map<String, dynamic>?> fetchAssignedRiderData() {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = firebaseAuth.currentUser;
  if (user != null && user.phoneNumber != null) {
    final String phoneNumber = user.phoneNumber!;    
    final Stream<QuerySnapshot> queryStream = FirebaseFirestore.instance
        .collection('fikisha_delivery_history')
        .doc(phoneNumber)
        .collection('deliveries_ordered')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
    return queryStream.map((querySnapshot) {
      if (querySnapshot.size > 0) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        if (documentSnapshot.exists) {
          Map<String, dynamic>? assignedRider =
              documentSnapshot['assigned_rider'] as Map<String, dynamic>?;
          return assignedRider;
        }
      }
      return null;
    });
  }
  return Stream.value(null);
}


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: fetchAssignedRiderData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return const Row(
          children: [
            Text('Connecting you to a rider soon...'),
             CircularProgressIndicator(),
          ],
        );
      } else {
        Map<String, dynamic> assignedRider = snapshot.data!;
        String assignedBike = assignedRider['bike'];
        String assignedRiderName = assignedRider['name'];
        String assignedRiderId = assignedRider['id'];
        String assignedRiderPhone = assignedRider['phone'];      
      return Container(
        padding: const EdgeInsets.only(top: 7),
        height: context.screenHeight() / 1.4,
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
              "Your Delivery is on the way",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: ColorPath.primarydark,
              ),
            ),
            const Text(
              "Please wait for the driver at the destination",
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
            const YMargin(14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "RIDERS INFORMATION",
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w300,
                          color: ColorPath.offBlack,
                        ),
                      ),
                      const YMargin(10),
                      Row(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // driversDetail(context);
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              ImagesAsset.driverpic))),
                                ),
                              ),
                              const XMargin(10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    assignedRiderName,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorPath.primarydark,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        assignedBike,
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: ColorPath.primarydark,
                                        ),
                                      ),
                                      Text(
                                        assignedRiderId,
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w600,
                                          color: ColorPath.primarydark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const XMargin(35),
                           Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.totalCost,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPath.primarydark,
                                  ),
                                ),
                                const Text(
                                  "Final Cost",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: ColorPath.primarydark,
                                  ),
                                ),
                              ])
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Current Location",
                            style: TextStyle(
                              fontSize: 9.0,
                              fontWeight: FontWeight.w400,
                              color: ColorPath.offBlack,
                            ),
                          ),
                          const YMargin(5),
                          Text(
                            widget.sourceLocation,
                            style: const TextStyle(
                              fontSize: 9.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF818181),
                            ),
                          ),
                          const YMargin(30),
                          const Text(
                            "Destination",
                            style: TextStyle(
                              fontSize: 9.0,
                              fontWeight: FontWeight.w400,
                              color: ColorPath.offBlack,
                            ),
                          ),
                          const YMargin(5),
                           Text(
                            widget.destinationLocation,
                            style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Call Rider",
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w300,
                          color: ColorPath.offBlack,
                        ),
                      ),
                      const YMargin(10),
                      Row(
                        children: [
                          TextButton(onPressed: () {
                            launch('tel:$assignedRiderPhone');
                          }, 
                          style: TextButton.styleFrom(
                            backgroundColor: ColorPath.primarygreen,
                            shape: const CircleBorder()
                          ),
                          child: const Icon(Icons.call,
                          color: ColorPath.primarydark,)
                          ),
                          const XMargin(5),
                          Text(
                            assignedRiderName,
                            style: const TextStyle(
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cancel Delivery",
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
                  onTap: () {
                    shareTripInfo(
                      context,
                      widget.sourceLocation, 
                      widget.destinationLocation, 
                      widget.totalCost
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Share Delivery Info',
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
  }}
  );}}
