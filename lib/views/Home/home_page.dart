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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart' ;
import 'package:google_maps_directions/google_maps_directions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> formKey = GlobalKey<ScaffoldState>();
  final LatLng center = const LatLng(-1.286389, 36.817223);
  final locationController = TextEditingController();
  late GoogleMapController controller;
  final PanelController panelController = PanelController();
  List<Marker> markers = [];
  LatLng? destination;
   Set<Polyline>polylines = {};
   final directions = GoogleMapsDirections();

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
        bikeType: data['bikeType'], 
        location: LatLng(location.latitude, location.longitude), 
        name: data['name'],
        cost: data['cost'],
        plateNo: data['plateNo']
        );
    }).toList();
    setState(() {
      markers = riders.map((rider) {
        return Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(2),
            markerId: MarkerId(rider.plateNo),
            position: rider.location,
            infoWindow: InfoWindow(
                title: rider.bikeType,
                snippet: '${rider.plateNo} - ${rider.cost}'));
      }).toList();
    });
  }

  // void onCameraIdle() async {
  //   if (destination == null) {
  //     return;
  //   }
  //   final LatLngBounds bounds = await controller.getVisibleRegion();
  //   if (bounds.contains(destination!)) {
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StreamBuilder(
  //           stream:
  //               FirebaseFirestore.instance.collection('Ambulances').snapshots(),
  //           builder: (context, snapshot) {
  //             if (!snapshot.hasData) {
  //               return CircularProgressIndicator();
  //             }
  //             return Expanded(
  //               child: ListView.builder(
  //                   itemCount: snapshot.data!.docs.length,
  //                   itemBuilder: (context, index) {
  //                     DocumentSnapshot ambulance = snapshot.data!.docs[index];
  //                     return ListTile(
  //                       onTap: () {},
  //                       trailing: Text(ambulance['plateNo']),
  //                       leading: CircleAvatar(
  //                         backgroundImage: NetworkImage(ambulance['image']),
  //                       ),
  //                       subtitle: Text(ambulance['cost']),
  //                       title: Text(ambulance['ambType']),
  //                     );
  //                   }),
  //             );
  //           },
  //         );
  //       },
  //     );
  //   }
  // }

  void onMapCreated(GoogleMapController mapController){
    controller = mapController;
  }

Future<Position> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission locationPermission;
  serviceEnabled  = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    throw 'Location service disabled';
  }
  locationPermission = await Geolocator.checkPermission();
  if(locationPermission == LocationPermission.deniedForever){
    throw 'Location service disabled, we cannot request permissions';
  }
  if (locationPermission == LocationPermission.denied){
    locationPermission = await Geolocator.requestPermission();
    if(locationPermission != LocationPermission.whileInUse && locationPermission != LocationPermission.always){
      throw 'Location permissions denied';
    }
  }
  return await Geolocator.getCurrentPosition();
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
    final destinationLatLng = LatLng(locations.first.latitude, locations.first.longitude);
    destination = destinationLatLng; // Set the destination coordinates
    controller.animateCamera(CameraUpdate.newLatLngZoom(destinationLatLng, 15));

    // Get the user's current location
    final userLocation = await getUserLocation();
    final userLatLng = LatLng(userLocation.latitude, userLocation.longitude);

    // Retrieve directions from user's location to the destination
    final directionsResult = await directions.directionsFromLocation(
      origin: userLatLng,
      destination: destinationLatLng,
      travelMode: DirectionsTravelMode.driving,
    );

    // Extract the polyline points from the directions result
    final polylinePoints = directionsResult.routes.first.polyline.points;

    // Create a polyline from the polyline points
    final polyline = Polyline(
      polylineId: const PolylineId('directions'),
      color: Colors.green,
      points: polylinePoints,
      width: 5,
    );

    setState(() {
      polylines = {polyline};
    });
  } catch (e) {
    print(e.toString());
  }
}


  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      key:  formKey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            // brightness: Brightness.dark,
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
                  formKey.currentState!.openDrawer();
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
          )
          ),
      drawer: const RyderDrawer(),
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
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(target: center, zoom: 15),
              onMapCreated: onMapCreated,
              markers: markers.toSet(),
              mapType: MapType.normal,
              polylines: polylines,
            ),
          ),
          Positioned(
              left: 16,
              right: 16,
              top: 18,
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
