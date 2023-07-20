// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:fikisha/views/Authentication/mobile_auth.dart';
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
  String verificationCode ='';
  TextEditingController phoneNumberController = TextEditingController();
  String verificationId = '';
  final auth = FirebaseAuth.instance;
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
                          Text(" Verify - ${widget.phonenumber}",
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
                    onCompleted: verifyOtp,            
              ),
            ),
            const YMargin(15),
            IconButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Homeview()));
                }, icon: const Icon(Icons.arrow_forward),
                ),
          ]),
        ));
  }


  Future<UserCredential> verifyOtp(String otp) async {
    var credentials = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationCode, 
        smsCode: otp,
        ));
        return credentials; 
  }
}
