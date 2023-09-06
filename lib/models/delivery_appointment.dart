
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryAppointment {
  final String date;
  final String amount;
  final String addressDestination;
  // final String packageType;
  final String sourceAddress;
  final String user;
  final Timestamp timestamp;
  final String phoneNumber;
  final String status;

  DeliveryAppointment({
    required this.date,
    required this.amount,
    required this.addressDestination,
    required this.sourceAddress,
    // required this.packageType,
    required this.user,
    required this.timestamp,
    required this.phoneNumber,
    required this.status
  });
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'address': addressDestination,
      'sourceAddress': sourceAddress,
      // 'packageType': packageType,
      'user': user,
      'timestamp': timestamp,
      'phoneNumber': phoneNumber,
      'status': status
    };
  }
}