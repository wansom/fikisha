// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/views/Home/home_page.dart';
import 'package:fikisha/views/Home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatefulWidget {
  final String phonenumber;

  const VerifyOtp({required this.phonenumber, Key? key}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController pinPutController = TextEditingController();
  String? verificationCode;
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
  String code = "";

  @override
  void initState() {
    verifyPhoneNumber();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPath.primarywhite,
        body: SingleChildScrollView(
          child: Column(children: [
            const YMargin(60),
            authHeader(context),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const YMargin(30),
                IconButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MobileAuth()));
                }, icon: const Icon(Icons.arrow_back),
                ),
                const Text(
                  "Verify Number",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorPath.primarydark,
                    fontSize: 23,
                  ),
                ),
                const YMargin(10),
                const Text("We sent a verification code to your phone number",
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
                          Text(" Verify ${widget.phonenumber}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorPath.primaryColor,
                                fontSize: 15.0,
                              )),
                          SvgPicture.asset(ImagesAsset.pen),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                            color: ColorPath.primarydark,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: InkWell(
                          onTap: () {},
                          child: const Center(
                              child: Text("Resend",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPath.primarywhite,
                                    fontSize: 9.0,
                                  ))),
                        ),
                      ),
                    ])),
            const YMargin(5),
            const Text("Enter the 6 digit otp",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorPath.primaryColor,
                  fontSize: 15.0,
                )),
            const YMargin(8.0),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: pinPutController,
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration?.copyWith(
                    color: const Color.fromARGB(255, 2, 5, 8),
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
                onCompleted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: verificationCode!, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homeview()),
                            (route) => false);
                      }
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
              ),
            ),
            const YMargin(15),
            IconButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomeScreen()));
                }, icon: const Icon(Icons.arrow_back),
                ),
            // const Spacer(),
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
            //     //CheckOtp Valid
            //     if (code.length == 6 && code == "123456") {
            //       Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const EmailVerification()));
            //     } else {}
            //   },
            // ),
            // const Spacer(),
          ]),
        ));
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
    verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+254${widget.phonenumber}',
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) async {
          if (value.user != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Homeview()),
                (route) => false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String? verificationId, int? resendToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
    );
  }
}
