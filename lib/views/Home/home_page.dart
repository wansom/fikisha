// ignore_for_file: avoid_print, unused_local_variable, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/models/riders.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/Components/rydr_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'as loc;
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> formKey = GlobalKey<ScaffoldState>();
  LatLng center = const LatLng(-1.286389, 36.817223);
  final locationController = TextEditingController();
  late GoogleMapController controller;
  final PanelController panelController = PanelController();
  List<Marker> markers = [];
  LatLng? destination;
   Set<Polyline>polylines = {};
   loc.LocationData? currentLocation;


  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    loadRiders();
  }
void getCurrentLocation() async{
  loc.Location location = loc.Location();
  location.getLocation().then((location) {
    currentLocation = location;
  });
  GoogleMapController googleMapController = controller;
  location.onLocationChanged.listen((newLocation) {
    currentLocation = newLocation;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(
        newLocation.latitude!, 
        newLocation.longitude!,
        ))));
        setState(() {
          
        });
  });
}

void loadRiders() async{
  final ridersDoc = await FirebaseFirestore.instance.collection('fikisha_riders_data').get();
  final riders = ridersDoc.docs.map((doc) {
    final data = doc.data();
    final location = data['location'];
    return RidersData(
      cost: data['cost'], 
      location: location, 
      name: data['name'], 
      plateNo: data['plateNo'], 
      bikeType: data['bikeType'],
      );
  }).toList();
  setState(() {
    markers = riders.map((rider){
      return Marker(
        markerId: MarkerId(rider.plateNo),
        position: rider.location,
        infoWindow: InfoWindow(
          title: rider.bikeType,
          snippet: '${rider.plateNo} : ${rider.cost}'
        )
      );
    }).toList();
  });
}

//  void loadRiders() async {
// final location = await Geolocator.getCurrentPosition();
// final LatLng userLocation = LatLng(location.latitude, location.longitude);
// final ridersDocs= await FirebaseFirestore.instance
//     .collection('fikisha_riders_data')
//     .get();
//     final riders = ridersDocs.docs.map((doc) {
//       final data = doc.data();
//       final location = data['location'] as GeoPoint;
//       return RidersData(
//         cost: data['cost'], 
//         location: data['location'], 
//         name: data['name'], 
//         plateNo: data['plateNo,'] ,
//         bikeType: data['bikeType']
//         );
//     }).toList();
// final ridersNearUser = riders.where((rider) {
//   final distance = Geolocator.distanceBetween(
//     rider.location.latitude,
//     rider.location.longitude,
//     userLocation.latitude,
//     userLocation.longitude,
//   );
//   return distance < 1000;
// }).toList();

// for (final rider in ridersNearUser) {
//   final marker = Marker(
//     icon: BitmapDescriptor.defaultMarkerWithHue(2),
//     markerId: MarkerId(rider.plateNo),
//     position: rider.location,
//     infoWindow: InfoWindow(
//         title: rider.bikeType,
//         snippet: '${rider.plateNo} - ${rider.cost}'),
//   );
//   markers.add(marker);
// }
//   }

  void onMapCreated(GoogleMapController mapController){
    controller = mapController;
  }


// Future<Position> getUserLocation() async {
//   bool serviceEnabled;
//   LocationPermission locationPermission;
//   serviceEnabled  = await Geolocator.isLocationServiceEnabled();
//   if(!serviceEnabled){
//     throw 'Location service disabled';
//   }
//   locationPermission = await Geolocator.checkPermission();
//   if(locationPermission == LocationPermission.deniedForever){
//     throw 'Location service disabled, we cannot request permissions';
//   }
//   if (locationPermission == LocationPermission.denied){
//     locationPermission = await Geolocator.requestPermission();
//     if(locationPermission != LocationPermission.whileInUse && locationPermission != LocationPermission.always){
//       throw 'Location permissions denied';
//     }
//   }
//   return await Geolocator.getCurrentPosition();
// }

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

   
  } catch (e) {
    print(e.toString());
  }
}

// List<LatLng>decodePolyline(String encodedPolyline) {
//   final List<LatLng> decodedPoints =[];
//   int index =0;
//   int lat = 0;
//   int lng= 0;
//   while (index < encodedPolyline.length) {
//     int shift = 0;
//     int results = 0;
//     while(true) {
//       int byte = encodedPolyline.codeUnitAt(index++) -63;
//       results |= (byte & 0x1F) << (shift * 5);
//       shift++;
//       if(byte < 0x20){
//         break;
//       }
//     }
//     lat += (results & 1)!=0?~(results >>1): (results >>1);
//     shift = 0;
//     results=0;

//     while(true) {
//       int byte = encodedPolyline.codeUnitAt(index++) -63;
//       results |= (byte & 0x1F) << (shift *5);
//       shift++;
//       if(byte < 0x20){
//         break;
//       }
//     }
//     lng += (results &1) != 0? ~(results>>1): (results>>1);
//     final latlng = LatLng(lat/1E5, lng/1E5);
//     decodedPoints.add(latlng);
//   }
//   return decodedPoints;
// }


  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.3;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.5;
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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              minHeight: panelHeightClosed,
             maxHeight: panelHeightOpened,
            controller: panelController,
            isDraggable: true,           
            panelBuilder: (controller) => Column(
              crossAxisAlignment:  CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width - 60,
                  height: 55,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Where to',
                      prefixIcon: const Icon(Icons.car_rental),
                      suffixIcon: IconButton(
                        onPressed: searchLocations,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.deepPurpleAccent,
                          size: 30,
                        ),
                      )),
                              ),
                ),
              ],
            ),           
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
        ],
      ),
    );
  }
}


