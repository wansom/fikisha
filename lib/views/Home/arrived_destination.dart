// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:fikisha/models/trip_rating.dart';
// import 'package:fikisha/utils/images_path.dart';
// import 'package:fikisha/utils/margins.dart';
// import 'package:fikisha/views/Home/share_trip.dart';
// import 'Components/rating_card.dart';
// import 'Components/sheet_header.dart';
// import 'build_trip_details.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fikisha/utils/colors.dart';
// import 'drivers_details.dart';

// arrivedDestination(BuildContext context) {
//   Navigator.pop(context);
//   showModalBottomSheet(
//       isDismissible: false,
//       isScrollControlled: true,
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       clipBehavior: Clip.hardEdge,
//       context: context,
//       builder: (context) {
//         return const ArrivedDestination();
//       });
// }

// class ArrivedDestination extends StatefulWidget {
//   const ArrivedDestination({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ArrivedDestinationState createState() => _ArrivedDestinationState();
// }

// class _ArrivedDestinationState extends State<ArrivedDestination> {
//   @override
//   void initState() {
//     setState(() {
//       Future.delayed(const Duration(seconds: 10), () {
//         shareTripInfo(context);
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 7),
//       height: context.screenHeight() / 1.64,
//       width: context.screenWidth(),
//       decoration: const BoxDecoration(
//         color: ColorPath.primarywhite,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15),
//           topRight: Radius.circular(15),
//         ),
//       ),
//       child: Column(
//         children: [
//           sheetHeader(),
//           const YMargin(15),
//           const Text(
//             "🎊 Rider has Arrived",
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.w500,
//               color: ColorPath.primarydark,
//             ),
//           ),
//           const Text(
//             "Your goods have arrived at your destination",
//             style: TextStyle(
//               fontSize: 11.0,
//               fontWeight: FontWeight.w300,
//               color: ColorPath.offBlack,
//             ),
//           ),
//           const YMargin(14),
//           const DotWidget(
//             dashColor: ColorPath.primaryfield,
//             dashHeight: 1.0,
//             dashWidth: 2.0,
//           ),
//           const YMargin(14),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "RIDERS INFORMATION",
//                       style: TextStyle(
//                         fontSize: 9.0,
//                         fontWeight: FontWeight.w300,
//                         color: ColorPath.offBlack,
//                       ),
//                     ),
//                     const YMargin(10),
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 driversDetail(context);
//                               },
//                               child: Container(
//                                 height: 60,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage(
//                                             ImagesAsset.driverpic))),
//                               ),
//                             ),
//                             const XMargin(10),
//                             const Column(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Warren Ochieng",
//                                   style: TextStyle(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.w700,
//                                     color: ColorPath.primarydark,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Honda Cycle 2010 |",
//                                       style: TextStyle(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: ColorPath.primarydark,
//                                       ),
//                                     ),
//                                     Text(
//                                       "237183AR",
//                                       style: TextStyle(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w600,
//                                         color: ColorPath.primarydark,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const XMargin(35),
//                         const Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "Ksh1,100",
//                                 style: TextStyle(
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w700,
//                                   color: ColorPath.primarydark,
//                                 ),
//                               ),
//                               Text(
//                                 "Final Cost",
//                                 style: TextStyle(
//                                   fontSize: 10.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: ColorPath.primarydark,
//                                 ),
//                               ),
//                             ])
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           const YMargin(14),
//           const DotWidget(
//             dashColor: ColorPath.primaryfield,
//             dashHeight: 1.0,
//             dashWidth: 2.0,
//           ),
//           const YMargin(14),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Delivery Details",
//                   style: TextStyle(
//                     fontSize: 9.0,
//                     fontWeight: FontWeight.w300,
//                     color: ColorPath.offBlack,
//                   ),
//                 ),
//                 const YMargin(5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(ImagesAsset.side),
//                     const XMargin(10),
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Current Location",
//                           style: TextStyle(
//                             fontSize: 9.0,
//                             fontWeight: FontWeight.w400,
//                             color: ColorPath.offBlack,
//                           ),
//                         ),
//                         YMargin(5),
//                         Text(
//                           "Mbale,Vihiga County",
//                           style: TextStyle(
//                             fontSize: 9.0,
//                             fontWeight: FontWeight.w300,
//                             color: Color(0xFF818181),
//                           ),
//                         ),
//                         YMargin(30),
//                         Text(
//                           "Destination",
//                           style: TextStyle(
//                             fontSize: 9.0,
//                             fontWeight: FontWeight.w400,
//                             color: ColorPath.offBlack,
//                           ),
//                         ),
//                         YMargin(5),
//                         Text(
//                           "Chavakali,Vihiga County",
//                           style: TextStyle(
//                             fontSize: 9.0,
//                             fontWeight: FontWeight.w300,
//                             color: ColorPath.offBlack,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const YMargin(14),
//           const DotWidget(
//             dashColor: ColorPath.primaryfield,
//             dashHeight: 1.0,
//             dashWidth: 2.0,
//           ),
//           const YMargin(14),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 "How was your Delivery?",
//                 style: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w700,
//                   color: ColorPath.primarydark,
//                 ),
//               ),
//               const YMargin(10.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 75),
//                 child: SizedBox(
//                   height: 40,
//                   // width: context.screenWidth(),
//                   child: ListView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     children: RatingData.rideDetails
//                         .map((rideDetails) => RideRating(
//                             rideModel: rideDetails,
//                             onSelected: (model) {
//                               setState(() {
//                                 for (var item in RatingData.rideDetails) {
//                                   item.isSelected = false;
//                                 }
//                                 model.isSelected = true;
//                               });
//                             }))
//                         .toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const YMargin(10.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 50),
//             child: Container(
//               height: 40,
//               width: context.screenWidth(),
//               decoration: BoxDecoration(
//                 color: ColorPath.primarydark,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: InkWell(
//                 onTap: () {},
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Share your info",
//                       style: TextStyle(
//                         color: ColorPath.primarywhite,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }