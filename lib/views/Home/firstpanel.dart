// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/views/Home/schedule_trip.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPanel extends StatefulWidget {
  final ScrollController controller; 
  const FirstPanel({super.key, required this.controller});

  @override
  State<FirstPanel> createState() => _FirstPanelState();
}

class _FirstPanelState extends State<FirstPanel> {
    final locationController = TextEditingController();
  late GoogleMapController controller;
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('fikisha_riders_data').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Flex(
         direction: Axis.vertical,
          children: [
            Expanded(
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: (snapshot.data as QuerySnapshot).docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot rider = (snapshot.data as QuerySnapshot).docs[index];
                        return ListTile(
                          onTap: () {
                            launch('tel:${rider.get('contact')}');
                          },
                          trailing: Text(rider['plateNo']),
                          title: Text(rider['bikeType']),
                          subtitle: Text(rider['cost']),
                        );
                      },
                    ),
                  ),
                  // const YMargin(10),
                          ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPath.primarydark,
          minimumSize: const Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
          onPressed: () {
            scheduleTrip(context,);
          }, 
          child: const Text('Schedule delivery'),
          )
                ],
              ),
            ),
          ),]
        );
      },
    );
  }
}