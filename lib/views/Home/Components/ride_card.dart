// // ignore_for_file: library_private_types_in_public_api, avoid_print, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fikisha/models/ride_model.dart';
// import 'package:fikisha/utils/images_path.dart';
// import 'package:fikisha/utils/margins.dart';
// import 'package:fikisha/views/Home/Components/home_extention.dart';
// import 'package:fikisha/utils/colors.dart';
// import '../vehicle_detail.dart';

// class RideCard extends StatefulWidget {
//   final RideModel rideModel;
//   final ValueChanged<RideModel> onSelected;

//   const RideCard({
//     required this.rideModel,
//     required this.onSelected,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _RideCardState createState() => _RideCardState();
// }

// class _RideCardState extends State<RideCard> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onLongPress: () {
//         print("long");
//         vehicleDetails(context);
//       },
//       child: Container(
//         color: widget.rideModel.isSelected
//             ? ColorPath.primarydark
//             : ColorPath.secondaryColor.withOpacity(0.3),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image(
//               width: 110,
//               height: 66,
//               image: AssetImage(widget.rideModel.image),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.rideModel.name,
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w700,
//                         color: widget.rideModel.isSelected
//                             ? ColorPath.secondaryColor
//                             : ColorPath.primarydark,
//                       ),
//                     ),
//                     Icon(
//                       Icons.info_outline,
//                       color: widget.rideModel.isSelected
//                           ? ColorPath.secondaryColor
//                           : ColorPath.primarydark,
//                       size: 8,
//                     )
//                   ],
//                 ),
//                 const YMargin(5),
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       ImagesAsset.time,
//                       color: widget.rideModel.isSelected
//                           ? ColorPath.secondaryColor
//                           : ColorPath.primarydark,
//                       height: 8,
//                       width: 8,
//                     ),
//                     const XMargin(3),
//                     Text(
//                       "21 mins",
//                       style: TextStyle(
//                         fontSize: 11.0,
//                         fontWeight: FontWeight.w300,
//                         color: widget.rideModel.isSelected
//                             ? ColorPath.secondaryColor
//                             : ColorPath.primarydark,
//                       ),
//                     ),
//                     const XMargin(3),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.person_outline,
//                           color: widget.rideModel.isSelected
//                               ? ColorPath.secondaryColor
//                               : ColorPath.primarydark,
//                           size: 10,
//                         ),
//                         Text(
//                           "3 items",
//                           style: TextStyle(
//                             fontSize: 11.0,
//                             fontWeight: FontWeight.w300,
//                             color: widget.rideModel.isSelected
//                                 ? ColorPath.secondaryColor
//                                 : ColorPath.primarydark,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const YMargin(5),
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       ImagesAsset.up,
//                       color: widget.rideModel.isSelected
//                           ? ColorPath.secondaryColor
//                           : ColorPath.primarydark,
//                     ),
//                     Text(
//                       "View delivery cost details",
//                       style: TextStyle(
//                         fontSize: 11.0,
//                         fontWeight: FontWeight.w300,
//                         color: widget.rideModel.isSelected
//                             ? ColorPath.secondaryColor
//                             : ColorPath.primarydark,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 17.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Ksh ${widget.rideModel.price}",
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: widget.rideModel.isSelected
//                           ? ColorPath.secondaryColor
//                           : ColorPath.primarydark,
//                     ),
//                   ),
//                   const YMargin(5.0),
//                   Text(
//                     widget.rideModel.time,
//                     style: TextStyle(
//                       fontSize: 9.0,
//                       fontWeight: FontWeight.w500,
//                       color: widget.rideModel.isSelected
//                           ? ColorPath.secondaryColor
//                           : ColorPath.primarydark,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ).ripple(() {
//         setState(() {
//           widget.onSelected(widget.rideModel);
//         });
//       }),
//     );
//   }
// }
