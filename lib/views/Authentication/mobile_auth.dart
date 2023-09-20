// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:fikisha/views/Home/delivery_splash.dart';
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
  bool isLoading = false;
  final TextEditingController pinPutController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
  setState(() {
    isLoading = true;
  });
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential).then((value) {
          print('Log in successful');
        });    
        setState(() {
          isLoading = true;
        });     
      }, 
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        setState(() {
          isLoading = true;
        });
      }, 
      codeSent: (String verificationId, int? resendToken) {
      setState(() {
        isLoading = false;
        otpVisible = true;
        this.verificationId = verificationId;
      });
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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_)=> const DeliveryOnboardingScreen())
          );
          Fluttertoast.showToast(
            msg: 'You are logged in successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16
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
                TextFormField(
                  key: formKey,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    filled: false,
                    hintText: 'Start with +254',
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
                    backgroundColor: ColorPath.secondarygrey,
                    minimumSize: const Size(250, 50)
                  ),                   
                  onPressed: () {
                  final phoneNumber = phoneNumberController.text;
                      if (otpVisible) {
                        verifyOtp();
                      } else {
                        loginWithPhone();
                    }
                  },
                  child: isLoading ?
                  const CircularProgressIndicator()
                  : Text(
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
          ))));
  }
  }
// bool validatePhoneNumber(String phoneNumber) {
//   if (phoneNumber.isEmpty) {
//     showDialog(
//       context: context, 
//       builder: (BuildContext context){
//         return const AlertDialog(
//           title: Text(
//             'Enter a valid phone number'
//           ),
//         );
//       });    
//   }
//   final cleanedValue = phoneNumber.replaceAll(RegExp(r'\D'), '');

//   if (cleanedValue.startsWith('0')) {
//     final formattedValue = '+254${cleanedValue.substring(1)}';
//     phoneNumberController.text = formattedValue;
//     return true;
//   }
//   return false;
// }

// Future<void> showDisclosureDialog(BuildContext context) async {
//   return showDialog<void> (
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: const Text(
//           'This app collects location data to enable efficient delivery services even when the app is closed or not in use.' 
//           'This data is used solely for the'
//           'purpose of providing accurate delivery tracking and optimizing routes.'
//         ),
//         title: const Text('Location Permissions'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             }, 
//             child: const Text('Cancel')
//             ),
//             ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const DeliveryOnboardingScreen()));
//             }, 
//             child: const Text('Continue')
//             ),
//         ],
//       );
//     }
//   );
// }
