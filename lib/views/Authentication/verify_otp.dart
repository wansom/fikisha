// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:fikisha/views/Home/delivery_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatefulWidget {
  final String phonenumber;

  const VerifyOtp({required this.phonenumber, Key? key}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController pinPutController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  User? user;
  bool isLoading = false;
  String verificationId ='';
  String code = "";

  final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
  fontSize: 20,
  color: Color.fromRGBO(30, 60, 87, 1),
  fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: const Color.fromARGB(255, 4, 7, 10)),
    borderRadius: BorderRadius.circular(20),
  ),
);

    @override
  void dispose() {
    super.dispose();
    pinPutController.dispose();
  }
  

  void verifyOtp() async {
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, 
      smsCode: code
      );
      await firebaseAuth.signInWithCredential(credential).then((value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      }).whenComplete(() {
        if(user != null) {
          Fluttertoast.showToast(
            msg: 'You are logged in successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16
          );
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_) => const DeliveryOnboardingScreen()),
            );
        } else {
          Fluttertoast.showToast(
            msg: 'Your login failed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 16
          );          
        }
      });
      } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPath.primarywhite,
        body: Column(children: [
          const YMargin(60),
          authHeader(context),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify Number",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorPath.primarydark,
                  fontSize: 23,
                ),
              ),
              YMargin(10),
              Text("We sent a verification code to your phone number",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorPath.primaryColor,
                    fontSize: 9.0,
                  )),
            ],
          ),
          const YMargin(10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(ImagesAsset.check),
                        Text(widget.phonenumber,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorPath.primarydark,
                              fontSize: 9.0,
                            )),
                        SvgPicture.asset(ImagesAsset.pen),
                      ],
                    ),
                    // Container(
                    //   height: 30,
                    //   width: 90,
                    //   decoration: BoxDecoration(
                    //       color: ColorPath.primarydark,
                    //       borderRadius: BorderRadius.circular(5.0)),
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: const Center(
                    //         child: Text("Resend",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w500,
                    //               color: ColorPath.primarywhite,
                    //               fontSize: 9.0,
                    //             ))),
                    //   ),
                    // ),
                  ])),
          const YMargin(5),
          const Text("Enter the 6 digit otp",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorPath.primaryColor,
                fontSize: 9.0,
              )),
          const YMargin(8.0),
           Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: pinPutController,
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration?.copyWith(
                    color: const Color.fromARGB(255, 222, 228, 233),
                  ),
                ),
                focusedPinTheme: defaultPinTheme.copyDecorationWith(
                  border:
                      Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                pinAnimationType: PinAnimationType.fade,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,           
              ),
          const YMargin(15),
          const Spacer(),
          // NumericPad(
          //   onNumberSelected: (value) {
          //     setState(() {
          //       if (value != -1) {
          //         if (code.length < 6) {
          //           code = code + value.toString();
          //         }
          //       } else {
          //         code = code.substring(0, code.length - 1);
          //       }
          //     });
          //   },
          //   onValidate: (value) {
          //   //  verifyOtp();
          //   //     Navigator.pushReplacement(
          //   //         context,
          //   //         MaterialPageRoute(
          //   //             builder: (context) => const DeliveryOnboardingScreen()));
          //   },
          // ),
          ElevatedButton(
            onPressed: () {
            verifyOtp();            
          }, 
          style: ElevatedButton.styleFrom(
             minimumSize: Size(context.screenWidth() /2, 50),
             backgroundColor: Colors.black
                  ),
          child: const Text('Next',),
          ),
          const Spacer()
        ]));
  }

  // Widget buildCodeNumberBox(String codeNumber) {
  //   return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 4),
  //       child: SizedBox(
  //         width: 47,
  //         height: 40,
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: ColorPath.primaryColor.withOpacity(0.3),
  //               borderRadius: const BorderRadius.all(
  //                 Radius.circular(5),
  //               ),
  //               border: Border.all(color: ColorPath.primaryColor, width: 0.5)),
  //           child: Center(
  //             child: Text(
  //               codeNumber,
  //               style: const TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.bold,
  //                 color: ColorPath.offWhite,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ));
  // }
}