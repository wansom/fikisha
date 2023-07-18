import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RidersData{
  final String name;
  final LatLng location;
  final String cost;
  final String plateNo;
  final String bikeType;

  RidersData({
    required this.cost,
    required this.location,
    required this.name,
    required this.plateNo,
    required this.bikeType
  });
  factory RidersData.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data()as Map<String, dynamic>;
    return RidersData( 
      location: data['location'], 
      name: data['name'],
      plateNo: data['plateNo'],
      cost: data['cost'],
      bikeType: data['bikeType']
      );
  }
}