import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Payment/payment.dart';
// import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:intl/intl.dart';
// import 'trip_history.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat('yyy-MM-dd').format(currentDate);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = firebaseAuth.currentUser;
  final String uid = user!.uid;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Your Delivery History"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const YMargin(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: ColorPath.primarydark,
                    ),
                    child:  Center(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w300,
                          color: ColorPath.secondaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 2000),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection(
                  'fikisha_delivery_history'
                ).doc(uid).collection('deliveries_ordered').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return const Column(
                      children: [
                         Text('Log in to have your delivery history here'),
                        CircularProgressIndicator()
                      ],
                    );
                  }   
                  return SizedBox(
                  height: context.screenHeight(),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot <Map<String, dynamic>> deliveryHistory = snapshot.data!.docs[index];
                      return tripCard(context, deliveryHistory);
                    },
                  ),
                );               
                },
                
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget tripCard(BuildContext context, DocumentSnapshot<Map<String, dynamic>> deliverySnapshot) {
  Map<String, dynamic> deliveryData = deliverySnapshot.data()!;
  String addressDestination  = deliveryData['address'] ?? 'No adress';
  String date = deliveryData['date'] ?? 'No date';
  String amount = deliveryData['amount'] ?? 'No amount';
  String sourceAddress = deliveryData['sourceAddress'] ?? 'No source destination';
  String packageType = deliveryData['packageType'] ?? 'No package type';
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
      height: 65,
      width: context.screenWidth(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: ColorPath.primaryfield,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Image(image: AssetImage(ImagesAsset.logosm)),
              ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressDestination,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: ColorPath.primarydark,
                    ),
                  ),
                  const YMargin(5),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 7.0,
                      fontWeight: FontWeight.w300,
                      color: ColorPath.primarydark,
                    ),
                  ),
                  Text(
                    packageType,
                    style: const TextStyle(
                      fontSize: 7.0,
                      fontWeight: FontWeight.w300,
                      color: ColorPath.primarydark,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: ColorPath.primarydark,
                ),
              ),
              const YMargin(5),
               Text(
                sourceAddress,
                style: const TextStyle(
                  fontSize: 7.0,
                  fontWeight: FontWeight.w300,
                  color: ColorPath.primarydark,
                ),
              )
            ],
          )
        ],
      ),
    ));
    // .ripple(() {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const TripHistory(),
    //       ));
    // }
    
}
