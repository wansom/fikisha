// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPanel extends StatefulWidget {
  final ScrollController controller; 
  const FirstPanel({super.key, required this.controller});

  @override
  State<FirstPanel> createState() => _FirstPanelState();
}

class _FirstPanelState extends State<FirstPanel> {

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
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: (snapshot.data as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot rider = (snapshot.data as QuerySnapshot).docs[index];
                  return ListTile(
                    onTap: () {
                      launch('tel:${rider.get('contact')}');
                    },
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(rider['image']),
                    // ),
                    trailing: Text(rider['plateNo']),
                    title: Text(rider['bikeType']),
                    subtitle: Text(rider['cost']),
                  );
                },
              ),
            ),
          ),]
        );
      },
    );
  }
}
