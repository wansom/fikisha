// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/views/Home/schedule_trip.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RideDetails extends StatefulWidget {
  const RideDetails({Key? key}) : super(key: key);

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('fikisha_riders_data').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        }
      return Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
      height: 250,
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
                                trailing: Text(rider['time']),
                                title: Text(rider['name']),
                                subtitle: Text(rider['price']),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(rider['image']),
                                ),
                              );
                            },
                          ),
          ),
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
          ),
        ],
      ),
            ),
          )
        ],
      );
      
  });
  }
}
