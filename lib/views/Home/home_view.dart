// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/models/riders.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/Components/rydr_drawer.dart';
import 'package:fikisha/views/Home/firstpanel.dart';
import 'package:fikisha/views/Home/schedule_trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart'  as loc;

class Homeview extends StatefulWidget {
  const Homeview({super.key,});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final LatLng center = const LatLng(-1.2921, 36.8219);
  final locationController = TextEditingController();
  final Completer<GoogleMapController> controller = Completer();
  final PanelController panelController = PanelController();
  static const LatLng sourceLocation =  LatLng(-1.286389, 36.817223);
  List<Marker> markers = [];
  String googleApiKey ="AIzaSyCoxCd3ZrbaeruLPg5irsJwOrBH1TS_FLU";
  loc.LocationData? currentLocation;
  late LatLng destination;
  List<LatLng> polylineCoordinates =[];
  String locationResult ='';



    void getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 11,
          target: LatLng(
            newLocation.latitude!, 
            newLocation.longitude!,
            ))));
            setState(() {
              
            });
    });
  }

    void setDestination (LatLng destinationLatlng) {
    setState(() {
      destination = destinationLatlng;
    });
    getPolyPoints();
  }

    void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey, 
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude), 
      PointLatLng(destination.latitude, destination.longitude),
      );
      if(result.points.isNotEmpty) {
        polylineCoordinates.clear();
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {
          
        });
      }
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


  void onMapCreated (mapController) {
            controller.complete(mapController);
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
      final newDestination = LatLng(locations.first.latitude, locations.first.longitude);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Destination:$query'),
      duration: const Duration(seconds: 2),));
      scheduleTrip(context,);
      setDestination(newDestination);
    } catch (e) {
      print(e.toString());
    }
  }
  
  @override
  void initState() {
  loadRiders();
  getPolyPoints();
  getCurrentLocation();  
  super.initState();
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
              polylines: {
               Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.blue,
              width: 6
            )
          },
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
              )
              ),
        ],
      ),
    );
  }
}
