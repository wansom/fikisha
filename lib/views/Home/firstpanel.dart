// ignore_for_file: deprecated_member_use, avoid_print

import 'package:fikisha/views/Home/build_select_ride.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirstPanel extends StatefulWidget {
  final ScrollController controller; 
  const FirstPanel({super.key, required this.controller});

  @override
  State<FirstPanel> createState() => _FirstPanelState();
}

class _FirstPanelState extends State<FirstPanel> {
    final locationController = TextEditingController();
  late GoogleMapController controller;
  int selectedItem = -1;
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
    return const RideDetails();
  }
}