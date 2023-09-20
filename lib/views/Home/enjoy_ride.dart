// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/views/Home/delivery_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:mpesadaraja/mpesadaraja.dart';
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

Future<Map<String, dynamic>?> fetchAssignedRiderData() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = firebaseAuth.currentUser;  
  if (user != null && user.phoneNumber != null) {
    final String phoneNumber = user.phoneNumber!;    
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('fikisha_delivery_history')
        .doc(phoneNumber)
        .collection('deliveries_ordered')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();      
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        
        if (documentSnapshot.exists) {
          final Map<String, dynamic>? assignedRider =
            documentSnapshot['assigned_rider'] as Map<String, dynamic>?;      
          return assignedRider;
        }
      }
    } catch (e) {
      print('Error fetching assigned rider data: $e');
    }
  }
  
  return null;
}

String formattedPhoneNumber(String phoneNumber) {
  if (phoneNumber.startsWith('+')) {
    return phoneNumber.substring(1); // Remove the first character (the + sign)
  }
  return phoneNumber; // Return the original number if it doesn't start with +
}

Future<void> initiatePayment() async {
  final stk = MpesaDaraja(
    consumerKey: 'DeaQyy3irhW2RsuaHSbNFRmmAgs6UAmb',
    consumerSecret: 'MaLnZGv0vheRW3Wv',
    passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
  );

  int amount = int.parse(widget.totalCost.replaceAll(RegExp(r'[^\d]'), ''));

  final User? user = FirebaseAuth.instance.currentUser;
  String userPhoneNumber = '';

  if (user != null) {
    userPhoneNumber = user.phoneNumber ?? '';
    userPhoneNumber = formattedPhoneNumber(userPhoneNumber);
  } else {
    return;
  }

  final result =await stk.lipaNaMpesaStk(
    "174379",
    amount,
    userPhoneNumber,
    "174379",
    userPhoneNumber,
    "https://a7ad-41-80-115-29.ngrok-free.app",
    "FIKISHA RIDERS",
    "transactionDesc",
  );
  if(result.isSuccessful) {
    String transactionDescription = 'Payment sent successfully to FIKISHA RIDERS.Thank you for working with Fikisha Mashinani.';
    updateFirestoreTransactionDescription(userPhoneNumber, transactionDescription);
  }
  if(result.Cancelled) {
    String transactionDescription = 'Delivery cancelled and no payment has been made. Thank you for working with Fikisha Mashinani.';
    updateFirestoreTransactionDescription(userPhoneNumber, transactionDescription);
  }
}

void updateFirestoreTransactionDescription  (String phoneNumber, String transactionDescription) async{
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('fikisha_delivery_history')
  .doc(phoneNumber)
  .collection('deliveries_ordered')
  .orderBy('timestamp')
  .limit(1)
  .get();
  if(querySnapshot.docs.isNotEmpty) {
    String documentId = querySnapshot.docs[0].id;
    await FirebaseFirestore.instance.collection('fikisha_delivery_history')
    .doc(phoneNumber)
    .collection('deliveries_ordered')
    .doc(documentId)
    .update({
      'transactionDescription': transactionDescription
    });
  }
}

void updateStatus (String phoneNumber) async {
  final docReference = FirebaseFirestore.instance
  .collection('fikisha_delivery_history')
  .doc(phoneNumber)
  .collection('deliveries_ordered')
  .doc();

  await docReference.update({
    'status': 'Completed'
  });
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchAssignedRiderData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if(snapshot.data != null) {
      Map<String, dynamic> assignedRider = snapshot.data!;
      String assignedBike = assignedRider['bike'];
      String assignedRiderName = assignedRider['name'];
      String assignedRiderImage = assignedRider['image'];
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
                            // ignore: unnecessary_null_comparison
                            assignedRiderImage == null
                            ? const CircleAvatar(
                              backgroundImage: AssetImage('assets/profile.png'),
                            ): CircleAvatar(
                              radius: 25,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/profile.png',
                                  image: assignedRiderImage,
                                  fit: BoxFit.cover
                                )
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
                                    // Text(
                                    //   assignedRiderId,
                                    //   style: const TextStyle(
                                    //     fontSize: 10.0,
                                    //     fontWeight: FontWeight.w600,
                                    //     color: ColorPath.primarydark,
                                    //   ),
                                    // ),
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 50),
          //   child: Container(
          //     height: 40,
          //     width: context.screenWidth(),
          //     decoration: BoxDecoration(
          //       color: ColorPath.primaryred,
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: const Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             "Cancel Delivery",
          //             style: TextStyle(
          //               color: ColorPath.primarywhite,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          const YMargin(8),
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: 40,
                width: context.screenWidth(),
                decoration: BoxDecoration(
                  color: ColorPath.primarygreen,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {                  
                   showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        content: const Text('Thank you for delivering with us'),
                        title: const Text('Delivery Complete'),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPath.primarygreen,
                            minimumSize: const Size(150 , 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const DeliveryOnboardingScreen())
                              );
                            },
                            child: const Text(
                              'Ok',
                            )
                          )
                        ],
                      );
                    },
                    );
                  },
                  child: const Text(
                    "Confirm delivery",
                    style: TextStyle(
                      color: ColorPath.primarywhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ), 
          //  Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 50),
          //   child: Container(
          //     height: 40,
          //     width: context.screenWidth(),
          //     decoration: BoxDecoration(
          //       color: ColorPath.primarydark,
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     child: InkWell(
          //       onTap: () {
          //         shareTripInfo(
          //           context,
          //           widget.sourceLocation, 
          //           widget.destinationLocation, 
          //           widget.totalCost
          //         );
          //       },
          //       child: const Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'Share Delivery Info',
          //             style: TextStyle(
          //               color: ColorPath.primarywhite,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    } else {
      return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 1.4,
      width: context.screenWidth(),
      decoration: const BoxDecoration(
        color: Colors.white
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
                          Container(
                            height: 50,
                            width:50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImagesAsset.ripple)
                              )
                            ),
                          ),
                          const Text(
                            'We are connecting you to your rider soon..',
                            style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w500,
                          color: ColorPath.primarygreen,
                        ),
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
        ],
      ),
     );
    }
  } else {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 1.4,
      width: context.screenWidth(),
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
                          Container(
                            height: 50,
                            width:50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImagesAsset.ripple)
                              )
                            ),
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
                                                 
        ],
      ),
     );
  }
  }
  );}
  }