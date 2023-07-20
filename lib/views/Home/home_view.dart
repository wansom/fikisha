// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/models/riders.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/Components/rydr_drawer.dart';
import 'package:fikisha/views/Home/firstpanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final LatLng center = const LatLng(-1.2921, 36.8219);
  final locationController = TextEditingController();
  late GoogleMapController controller;
  final PanelController panelController = PanelController();
  List<Marker> markers = [];
  LatLng? destination;

  @override
  void initState() {
    super.initState();
    loadRiders();
  }

  void loadRiders() async {
    final ridersDocs =
        await FirebaseFirestore.instance.collection('fikisha_riders_data').get();
    final riders = ridersDocs.docs.map((doc) {
      final data = doc.data();
      final location = data['location'] as GeoPoint;
      return RidersData(
        plateNo: data['plateNo'],
        bikeType: data['bikeType'],
        location: LatLng(location.latitude, location.longitude),
        cost: data['cost'],
        name: data['name'], 
        contact: data['contact']
      );
    }).toList();
    setState(() {
      markers = riders.map((rider) {
        return Marker(
            markerId: MarkerId(rider.plateNo),
            position: rider.location,
            infoWindow: InfoWindow(
                title: rider.bikeType,
                snippet: '${rider.plateNo} - ${rider.cost}'));
      }).toList();
    });
  }


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
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      key: _key,
      drawer: const RyderDrawer(),
       appBar: PreferredSize(       
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: ColorPath.primarydark,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 5, bottom: 5),
                child: Container(
                  width: 45,
                  decoration: const BoxDecoration(
                      color: ColorPath.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      ImagesAsset.drawer,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ).ripple(() {
                  _key.currentState!.openDrawer();
                }),
              )
            ],
            centerTitle: false,
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, Warren 👋🏾",
                  style: TextStyle(
                    color: ColorPath.primarywhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "Order a delivery now!",
                  style: TextStyle(
                    color: ColorPath.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          ),
      body: Stack(
        children: [
          SlidingUpPanel(          
            panelBuilder: (controller) => FirstPanel(
              controller: controller,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              minHeight: panelHeightClosed,
             maxHeight: panelHeightOpened,
            controller: panelController,
            isDraggable: true,
            body: GoogleMap(
              initialCameraPosition: CameraPosition(target: center, zoom: 11.5),
              onMapCreated: onMapCreated,
              markers: markers.toSet(),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ),
          Positioned(
              left: 16,
              right: 16,
              top: 20,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Enter destination',
                    suffixIcon: IconButton(
                      onPressed: searchLocations,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.deepPurpleAccent,
                        size: 30,
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
