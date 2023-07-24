import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideModel {
   int id;
  String name;
  String image;
  String price;
  String time;
  LatLng location;
  String contact;
  bool isSelected;

  RideModel ({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.time,
    required this.location,
    required this.contact,
    this.isSelected = false
  });
   factory RideModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data()as Map<String, dynamic>;
    return RideModel( 
     id : data['id'],
     image: data['image'],
     price: data['price'],
     time: data['time'], 
     name: data['name'],
     location: data['location'],
     contact: data['contact'],
      );
  }
  }