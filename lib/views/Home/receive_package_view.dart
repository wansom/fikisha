// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/models/delivery_appointment.dart';
import 'package:fikisha/models/ride_model.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/Components/rydr_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mpesadaraja/mpesadaraja.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

class ReceivePackageView extends StatefulWidget {
  const ReceivePackageView({super.key});

  @override
  State<ReceivePackageView> createState() => _ReceivePackageViewState();
}

class _ReceivePackageViewState extends State<ReceivePackageView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final LatLng center = const LatLng(-1.2921, 36.8219);
  final locationController = TextEditingController();
  final preferredLocationController = TextEditingController();
  late GoogleMapController controller;
  late final ScrollController scrollController;
  final PanelController panelController = PanelController();
  List<Marker> markers = [];
  String googleApiKey ="AIzaSyCoxCd3ZrbaeruLPg5irsJwOrBH1TS_FLU";
  loc.LocationData? currentLocation;
  LatLng? destination;
  Set<Polyline> polylines ={};
  String eta ='';
  String distance = '';
  String calculatedTotalCost ='';
  LatLng? preferredLocation;  
  bool isCustomLocation = false;
  final phoneNumberController = TextEditingController();
  final packageController = TextEditingController();

  void getCurrentLocation() async {
  loc.Location location = loc.Location();
  location.getLocation().then((location) async {
    currentLocation = location;
    String currentAddress = await getAddressFromCoordinates(
      location.latitude!, location.longitude!);
    preferredLocationController.text = currentAddress;
  });
  GoogleMapController googleMapController = controller;
  location.onLocationChanged.listen((newLocation) {
    currentLocation = newLocation;
    // Update the map with the new location.
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

void onSetLocationButtonClicked() async {
  String preferredLocationQuery = preferredLocationController.text;
  List<Location> locations = await locationFromAddress(preferredLocationQuery);
  if (locations.isNotEmpty) {
    // Convert LatLng to loc.LocationData and update currentLocation.
    loc.LocationData newLocationData = loc.LocationData.fromMap({
      'latitude': locations.first.latitude,
      'longitude': locations.first.longitude,
    });
    setState(() {
      currentLocation = newLocationData;
    });

    // Optionally, update the map to show the new current location.
    GoogleMapController googleMapController = controller;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(newLocationData.latitude!, newLocationData.longitude!),
          zoom: 11,
        ),
      ),
    );
    addRoutePolyline();
    getDirections();
  } else {
    // Handle case when no location is found for the entered query.
    print('Location not found for the given search query.');
  }
}

Future getUserPhoneNumber() async {
  final User? user =FirebaseAuth.instance.currentUser;
  if(user!= null) {
    String uid = user.uid;
    final fikishaLoggedInUsers = FirebaseFirestore.instance.collection('fikisha_logged_in_users').doc(uid);
    final docSnapshot = await fikishaLoggedInUsers.get();
    if(docSnapshot.exists){
      return docSnapshot.get('phone');
    }
  }
}

Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    final apiKey = googleApiKey;
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        Map<String, dynamic> data = json.decode(response.body);
        if(data['status'] == 'OK'){
          return data['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

void getDirections() async {
  if (currentLocation == null || destination == null) {
    return;
  }
  String apiUrl =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation!.latitude},${currentLocation!.longitude}&destination=${destination!.latitude},${destination!.longitude}&key=$googleApiKey';
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final durationText = data['routes'][0]['legs'][0]['duration']['text'] as String;
    final distanceText = data['routes'][0]['legs'][0]['distance']['text'] as String;
    setState(() {
      eta = durationText;
      distance = distanceText;
    });
  } else {
    print('Failed to fetch directions.');
  }
}

  // void loadRiders() async {
  //   final ridersDocs =
  //       await FirebaseFirestore.instance.collection('fikisha_riders_data').get();
  //   final riders = ridersDocs.docs.map((doc) {
  //     final data = doc.data();
  //     final location = data['location'] as GeoPoint;
  //     return RideModel(
  //       name: data['name'],
  //       location: LatLng(location.latitude, location.longitude),
  //       price: data['price'],
  //       id: data['id'], 
  //       contact: data['contact'], 
  //       image: '', 
  //       time: ''
  //     );
  //   }).toList();
  //   setState(() {
  //     markers = riders.map((rider) {
  //       return Marker(
  //           markerId: MarkerId(rider.name),
  //           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //           position: rider.location,
  //           infoWindow: InfoWindow(
  //               title: rider.name,
  //               snippet: calculatedTotalCost));
  //     }).toList();
  //   });  
  // }

  void onMapCreated (mapController) {
    controller =  mapController;
  }

void onSearchLocation() async {
  String query = locationController.text;
  List<Location> locations = await locationFromAddress(query);
  if (locations.isNotEmpty) {
    setState(() {
      destination = LatLng(locations.first.latitude, locations.first.longitude);
    });
    controller.animateCamera(CameraUpdate.newLatLng(destination!));
    addRoutePolyline();
    getDirections();
    // scheduleTrip(context);
    if (currentLocation != null && destination != null) {
      // Calculate the distance in kilometers between current location and destination
      double distanceInKm = Geolocator.distanceBetween(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        destination!.latitude,
        destination!.longitude,
      ) / 1000; // Convert distance to kilometers

      // Define the price per kilometer
      double price5PerKm = 100.0;

      // Define price for extra km
      double pricePerExtraKm = 3.0;

      // Calculate the price based on the distance
      double calculatedPriceValue = 0;
      if(distanceInKm <=5) {
        calculatedPriceValue = price5PerKm;
      } else {
        calculatedPriceValue = price5PerKm +(distanceInKm - 5) *pricePerExtraKm;
      }

      // Update the calculatedPrice variable with the formatted price
      calculatedTotalCost = 'sh. ${calculatedPriceValue.toStringAsFixed(0)}';

      setState(() {
      });
      showDeliveryDetails(context);
    } else {
      print('Error: Unable to calculate distance or destination is null.');
    }
  } else {
    // Handle case when no location is found for the search query.
    print('Location not found for the given search query.');
  }
}

showDeliveryDetails(context) async {
  final riderDocs = await FirebaseFirestore.instance.collection('fikisha_riders_data').
  get();
  final rider = riderDocs.docs.map((doc)  {
    final data = doc.data();
    return RideModel(
      image: data['image'],
      );
  });
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat('yyy-MM-dd').format(currentDate);
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    elevation: 0,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height *0.9,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [              
              Text(
                 'Get package from ${locationController.text}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorPath.primaryblack
                ),
              ),
              const YMargin(5),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(rider.first.image),
                ), 
                trailing: Text(
                calculatedTotalCost,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),
              ),
              title: const Text(
                'Get your package',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(
                'Package arrives in $eta',
                style: const TextStyle(
                  color: ColorPath.primaryblack,
                  fontSize: 15,
                ),
              ),
              ),
               TextField(
                    controller: packageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Enter the package name as wrapped',                        
                        ),
                  ),        
              const YMargin(15),
              ElevatedButton(
                onPressed: () async{
                  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  final User? user = firebaseAuth.currentUser;
                  if(user!=null) {
                    final String uid = user.uid;
                    DeliveryAppointment deliveryAppointment = DeliveryAppointment(
                    date: formattedDate, 
                    addressDestination: locationController.text, 
                    amount: calculatedTotalCost,
                    sourceAddress: preferredLocationController.text,
                    packageType: packageController.text
                    );
                    await FirebaseFirestore.instance.collection(
                      'fikisha_delivery_history'
                    ).doc(uid).collection('deliveries_ordered').add(deliveryAppointment.toJson());
                  } else {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text(
                            'Log in first to access your delivery history'
                          ),
                        );
                      }
                      );
                  }     
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Delivery status',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        content: const Text(
                          'Delivery appointment added: pending'
                        ),
                        actions: [
                          ElevatedButton(onPressed: () {
                            Navigator.of(context).pop();
                          }, 
                          child: const Text(
                            'Go Back'
                          )
                          )
                        ],
                      );
                    },
                    );
                },  
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPath.primaryblack,
              minimumSize: Size(MediaQuery.of(context).size.width , 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
               ),
            ),
                child: const Text(
                  'Confirm delivery',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                ),
                const YMargin(15),
                ElevatedButton(
                onPressed: initiatePayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPath.primaryblack,
              minimumSize: Size(MediaQuery.of(context).size.width , 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
               ),
            ),
                child: const Text(
                  'Pay via Mpesa',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                )
            ],
          ),
        ),
      );
    },
    );
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

  int amount = int.parse(calculatedTotalCost.replaceAll(RegExp(r'[^\d]'), ''));

  final User? user = FirebaseAuth.instance.currentUser;
  String userPhoneNumber = ''; // Declare the variable outside the if block

  if (user != null) {
    userPhoneNumber = user.phoneNumber ?? '';
    userPhoneNumber = formattedPhoneNumber(userPhoneNumber);
  } else {
    // Handle the case where the user is not logged in or phone number is not available.
    // You can show an error message or take appropriate action.
    return;
  }

  await stk.lipaNaMpesaStk(
    "174379",
    amount,
    userPhoneNumber,
    "174379",
    userPhoneNumber,
    "https://a7ad-41-80-115-29.ngrok-free.app",
    "FIKISHA RIDERS",
    "transactionDesc",
  );
}


// Future<void> initiatePayment() async {
//   final stk = MpesaDaraja(
//     consumerKey: 'DeaQyy3irhW2RsuaHSbNFRmmAgs6UAmb',
//     consumerSecret: 'MaLnZGv0vheRW3Wv',
//     passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
//   );

//   // // Ensure the user is logged in before proceeding
//   final User? user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     // Handle the case where the user is not logged in.
//     // You can show a login screen or take appropriate action.
//     return;
//   }

//   // // Get the user's phone number from Firebase Authentication
//   final String? userPhoneNumber = user.phoneNumber;
//   if (userPhoneNumber == null) {
//     // Handle the case where the user's phone number is not available.
//     // You can show an error message or take appropriate action.
//     return;
//   }

//   // // Extract the amount from calculatedTotalCost
//   int amount = int.parse(calculatedTotalCost.replaceAll(RegExp(r'[^\d]'), ''));

//   // Make the STK push request
//   await stk.lipaNaMpesaStk(
//     "174379",
//     amount,
//     userPhoneNumber,
//     "174379",
//     userPhoneNumber,
//     "https://22a1-105-163-1-5.ngrok-free.app",
//     "FIKISHA RIDERS",
//     "transactionDesc",
//   );
// }


  void addRoutePolyline() async {
    if (currentLocation != null) {
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey, // Replace with your actual Google Maps API key
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(destination!.latitude, destination!.longitude),
      );
      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        setState(() {
          polylines.clear();
          polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.red,
              width: 6,
            ),
          );
        });
      }
    }
  }
  
  @override
  void initState() {
  // loadRiders();
  addRoutePolyline();
  getCurrentLocation();  
  super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    preferredLocationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     final user = FirebaseAuth.instance.currentUser?.displayName ?? 'Hello 👋🏾';
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
            title:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: const TextStyle(
                    color: ColorPath.primarywhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                const Text(
                  "Order a delivery now!",
                  style: TextStyle(
                    color: ColorPath.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(target: center, zoom: 11.5),
              onMapCreated: onMapCreated,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: {
                ...markers.toSet(),
                if(destination != null) 
                Marker(
                  markerId: const MarkerId('destination'),
                  position: LatLng(
                    destination!.latitude,
                    destination!.longitude
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                  infoWindow: InfoWindow(
                    title: locationController.text,
                    snippet: 'Arrive in $eta' 
                      )
                ),
                if(currentLocation!=null)
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!
                  ),
                  infoWindow:  InfoWindow(
                    title: 'Your location',
                    snippet: distance
                  )
                ),                
              },
              polylines: polylines
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 20,
              child: Column(
                children: [
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Where it\' coming from...',
                        suffixIcon: IconButton(
                          onPressed: onSearchLocation,
                          icon: const Icon(Icons.search,
                          color: Colors.black,
                          size: 25,),
                        ),
                        ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: preferredLocationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Where it\'s going to..',
                        suffixIcon: IconButton(
                          onPressed: onSetLocationButtonClicked,
                          icon: const Icon(Icons.location_pin,
                          color: Colors.black,
                          size: 25,),
                        )
                        ),
                  ),                                 
                ],
              )
              )        ]
          ),          
    );
  }
}