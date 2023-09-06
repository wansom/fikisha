// // ignore_for_file: library_private_types_in_public_api

// import 'package:fikisha/views/Authentication/mobile_auth2.dart';
// import 'package:fikisha/views/Home/delivery_splash.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fikisha/utils/images_path.dart';
// import 'package:fikisha/utils/margins.dart';
// import 'package:fikisha/views/Authentication/components/auth_header.dart';
// import 'package:fikisha/utils/colors.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class VerifyOtp extends StatefulWidget {
//   final String phonenumber;

//   const VerifyOtp({required this.phonenumber, Key? key}) : super(key: key);

//   @override
//   _VerifyOtpState createState() => _VerifyOtpState();
// }

// class _VerifyOtpState extends State<VerifyOtp> {
//   final firebaseAuth = FirebaseAuth.instance;
//   User? user;
//   String verificationId ='';
//   String code = "";
  
//   void verifyOtp() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId, 
//       smsCode: code
//       );
//       await firebaseAuth.signInWithCredential(credential).then((value) {
//         setState(() {
//           user = FirebaseAuth.instance.currentUser;
//         });
//       }).whenComplete(() {
//         if(user != null) {
//           Fluttertoast.showToast(
//             msg: 'You are logged in successfully',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 2,
//             backgroundColor: Colors.black,
//             textColor: Colors.white,
//             fontSize: 16
//           );
//           Navigator.pushReplacement(
//             context, 
//             MaterialPageRoute(builder: (_) => const DeliveryOnboardingScreen()),
//             );
//         } else {
//           Fluttertoast.showToast(
//             msg: 'Your login failed',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 2,
//             backgroundColor: Colors.white,
//             textColor: Colors.red,
//             fontSize: 16
//           );
//         }
//       });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: ColorPath.primarywhite,
//         body: Column(children: [
//           const YMargin(60),
//           authHeader(context),
//           const Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Verify Number",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: ColorPath.primarydark,
//                   fontSize: 23,
//                 ),
//               ),
//               YMargin(10),
//               Text("We sent a verification code to your phone number",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: ColorPath.primaryColor,
//                     fontSize: 9.0,
//                   )),
//             ],
//           ),
//           const YMargin(10),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         SvgPicture.asset(ImagesAsset.check),
//                         Text(widget.phonenumber,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: ColorPath.primarydark,
//                               fontSize: 9.0,
//                             )),
//                         SvgPicture.asset(ImagesAsset.pen),
//                       ],
//                     ),
//                     Container(
//                       height: 30,
//                       width: 90,
//                       decoration: BoxDecoration(
//                           color: ColorPath.primarydark,
//                           borderRadius: BorderRadius.circular(5.0)),
//                       child: InkWell(
//                         onTap: () {},
//                         child: const Center(
//                             child: Text("Resend",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: ColorPath.primarywhite,
//                                   fontSize: 9.0,
//                                 ))),
//                       ),
//                     ),
//                   ])),
//           const YMargin(5),
//           const Text("Enter the 6 digit otp",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: ColorPath.primaryColor,
//                 fontSize: 9.0,
//               )),
//           const YMargin(8.0),
//           SingleChildScrollView(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildCodeNumberBox(code.isNotEmpty ? code.substring(0, 1) : ""),
//                 buildCodeNumberBox(code.length > 1 ? code.substring(1, 2) : ""),
//                 buildCodeNumberBox(code.length > 2 ? code.substring(2, 3) : ""),
//                 buildCodeNumberBox(code.length > 3 ? code.substring(3, 4) : ""),
//                 buildCodeNumberBox(code.length > 4 ? code.substring(4, 5) : ""),
//                 buildCodeNumberBox(code.length > 5 ? code.substring(5, 6) : ""),
//               ],
//             ),
//           ),
//           const YMargin(15),
//           const Spacer(),
//           NumericPad(
//             onNumberSelected: (value) {
//               setState(() {
//                 if (value != -1) {
//                   if (code.length < 6) {
//                     code = code + value.toString();
//                   }
//                 } else {
//                   code = code.substring(0, code.length - 1);
//                 }
//               });
//             },
//             onValidate: (value) {
//             //  verifyOtp();
//             //     Navigator.pushReplacement(
//             //         context,
//             //         MaterialPageRoute(
//             //             builder: (context) => const DeliveryOnboardingScreen()));
//             },
//           ),
//           ElevatedButton(
//             onPressed: () {
//             verifyOtp();
//             // Navigator.pushReplacement(context, 
//             // MaterialPageRoute(builder: (_)=> const DeliveryOnboardingScreen())
//             // );
//           }, 
//           style: ElevatedButton.styleFrom(
//              minimumSize: Size(context.screenWidth() /2, 50),
//              backgroundColor: Colors.black
//                   ),
//           child: const Text('Next',),
//           ),
//           const Spacer()
//         ]));
//   }

//   Widget buildCodeNumberBox(String codeNumber) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         child: SizedBox(
//           width: 47,
//           height: 40,
//           child: Container(
//             decoration: BoxDecoration(
//                 color: ColorPath.primaryColor.withOpacity(0.3),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(5),
//                 ),
//                 border: Border.all(color: ColorPath.primaryColor, width: 0.5)),
//             child: Center(
//               child: Text(
//                 codeNumber,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: ColorPath.offWhite,
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }