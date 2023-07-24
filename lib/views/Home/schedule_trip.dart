// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/models/delivery_appointment.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'Components/sheet_header.dart';
import 'package:fikisha/utils/colors.dart';
import 'build_trip_details.dart';
import 'package:intl/intl.dart';

scheduleTrip(BuildContext context) {
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return  const SingleChildScrollView(child: ScheduleTrip());
      });
}

class ScheduleTrip extends StatefulWidget {
  const ScheduleTrip({Key? key}) : super(key: key);

  @override
  _ScheduleTripState createState() => _ScheduleTripState();
}

class _ScheduleTripState extends State<ScheduleTrip> {
  final formKey = GlobalKey<FormState>();
  final dateKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final nameController = TextEditingController();
  final destinationController = TextEditingController();
  final phoneNumberController = TextEditingController();

   @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 7),
        height: context.screenHeight() / 0.9,
        width: context.screenWidth(),
        decoration: const BoxDecoration(
          color: ColorPath.primarywhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
          sheetHeader(),
          const YMargin(15),
          const Text(
        "Schedule a Delivery",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: ColorPath.primarydark,
        ),
          ),
          const Text(
        "Book a ride for later?",
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w300,
          color: ColorPath.offBlack,
        ),
          ),
          const YMargin(10),
          const DotWidget(
        dashColor: Color.fromARGB(255, 2, 2, 2),
        dashHeight: 1.2,
        dashWidth: 2.0,
          ),
          const YMargin(20),          
        SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextFormField(
                            controller: destinationController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: const Icon(Icons.edit),
                                labelText: 'Destination'),                          
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name of receiver';
                              }
                              return null;
                            },
                          ),
                ),
                const YMargin(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: const Icon(Icons.edit),
                                labelText: 'Recipient name'),                          
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name of receiver';
                              }
                              return null;
                            },
                          ),
                ),
                const YMargin(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: const Icon(Icons.call ),
                                labelText: 'Receiver phone number'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter reciever phone number';
                              }
                              return null;
                            },
                          ),
                ),
                const YMargin(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: const Icon(Icons.calendar_month_outlined),
                                labelText: 'Date'),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2027));
                              if (pickedDate != null) {
                                setState(() {
                                  dateController.text =
                                      DateFormat('yyy-MM-dd').format(pickedDate);
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter date';
                              }
                              return null;
                            },
                          ),
                ),                        
              const YMargin(10),
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: TextFormField(
                        controller: timeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(Icons.punch_clock),
                            labelText: 'Select Time'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 00, minute: 00),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}: ${pickedTime.minute.toString().padLeft(2, '0')}';
                              timeController.text = formattedTime;
                            });
                          }
                        },
                        validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter time';
                        }
                        return null;
                      },
                      ),
            ),
              ],
            ),
          ),
        ),
          const YMargin(10),
          ElevatedButton(
            onPressed: () {           
              if(formKey.currentState!.validate()) {
                DeliveryAppointment deliveryAppointment = DeliveryAppointment(date: 
                dateController.text, time: timeController.text,
                destination: destinationController.text,
                name: nameController.text, phoneNumber: phoneNumberController.text
                );
                FirebaseFirestore.instance.collection('fikisha_users').add(deliveryAppointment.toJson()).then((value) {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Schedule status'),
                        content: const Text(
                          'Delivery scheduled successfully',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ))
                        ],
                      );
                    });
                }).catchError((e) {
                  showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Appointment status'),
                                content: Text(
                                  'Failed to add appointment $e.\n Contact support.',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            });
                });
              }
              Navigator.of(context).pop();
            }, 
            child: const Text('Save'),
            )
        ],
        ));
  }
}
