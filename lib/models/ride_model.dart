import 'package:fikisha/utils/images_path.dart';

class RideModel {
  int id;
  String name;
  String image;
  String price;
  String time;
  bool isSelected;

  RideModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.time,
    this.isSelected = false,
  });
}

class RideData {
  static List<RideModel> rideDetails = <RideModel>[
    RideModel(
      image: ImagesAsset.bike1,
      isSelected: true,
      name: "Fikisha Regular",
      price: "1,100",
      time: "07: 38 pm",
      id: 1,
    ),
    RideModel(
      image: ImagesAsset.bike2,
      name: "Fikisha Classic",
      price: "2,200",
      time: "07: 38 pm",
      id: 2,
    ),
    RideModel(
      image: ImagesAsset.bike3,
      name: "Fikisha Premium",
      price: "3,200",
      time: "07: 38 pm",
      id: 1,
    ),
  ];
}
