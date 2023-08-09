// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:fikisha/views/Home/delivery_splash.dart';
// import 'package:fikisha/views/Home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class MobileAuth extends StatefulWidget {
  const MobileAuth({Key? key}) : super(key: key);

  @override
  _MobileAuthState createState() => _MobileAuthState();
}

class _MobileAuthState extends State<MobileAuth> {
  TextEditingController phoneNumberController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  String verificationId ='';
  bool otpVisible= false;
  User? user;

   final TextEditingController pinPutController = TextEditingController();
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
    phoneNumberController.dispose();
    pinPutController.dispose();
  }

 void loginWithPhone() async {
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential).then((value) {
          print('Log in successful');
        });
      }, 
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      }, 
      codeSent: (String verificationId, int? resendToken) {
        otpVisible  =true;
        this.verificationId = verificationId;
        setState(() {});
      }, 
      codeAutoRetrievalTimeout: (String verificationId) {},
      );
  }

void verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, 
      smsCode: pinPutController.text,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPath.primarywhite,
      body: SingleChildScrollView(
        child: FadeInDown(
          duration: const Duration(
            milliseconds: 2000,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const YMargin(100),
                authHeader(context),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let’s know you",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorPath.primarydark,
                        fontSize: 23,
                      ),
                    ),
                    YMargin(10),
                    Text("Please enter your Mobile Number",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: ColorPath.primarydark,
                          fontSize: 14,
                        )),
                    YMargin(3.0),
                    Text("An OTP will be sent you for verification?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorPath.primaryColor,
                          fontSize: 9.0,
                        )),
                  ],
                ),
                const YMargin(25),
                TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    filled: false,
                    hintText: '+254700000000',
                    // prefixText: '+254',
                    prefixIcon: Icon(Icons.phone_iphone)),
                maxLength: 13,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
              ),              
                const YMargin(30),
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
              ),
            ),
            const YMargin(30),
                ElevatedButton(  
                  style: ElevatedButton.styleFrom(
                    backgroundColor:ColorPath.secondarygrey,
                    minimumSize: const Size(250, 50)
                  ),                   
                  onPressed:() {
                    if(otpVisible){
                      verifyOtp();
                    } else {
                      loginWithPhone();
                    }
                  },
                  child:  Text(
                    otpVisible ? 'Verify' : 'Login',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorPath.primarywhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),     
              ],
            ),
          ),
        ),
      ),
    );
  }
  }