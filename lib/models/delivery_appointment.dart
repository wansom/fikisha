class DeliveryAppointment {
  final String date;
  final String amount;
  final String addressDestination;
  final String packageType;
  final String sourceAddress;

  DeliveryAppointment({
    required this.date,
    required this.amount,
    required this.addressDestination,
    required this.sourceAddress,
    required this.packageType
  });
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'address': addressDestination,
      'sourceAddress': sourceAddress,
      'packageType': packageType
    };
  }
}