class DeliveryAppointment {
  final String date;
  final String time;
  final String name;
  final String destination;
  final String phoneNumber;
  DeliveryAppointment({
    required this.date,
    required this.name,
    required this.phoneNumber,
    required this.time,
    required this.destination
  });
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'phoneNumber': phoneNumber,
      'name': name
    };
  }
}