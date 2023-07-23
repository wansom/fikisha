// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikisha/views/Authentication/verify_otp.dart';
import 'package:fikisha/views/Home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:pinput/pinput.dart';

class MobileAuth extends StatefulWidget {
  const MobileAuth({Key? key}) : super(key: key);

  @override
  _MobileAuthState createState() => _MobileAuthState();
}

class _MobileAuthState extends State<MobileAuth> {
  TextEditingController phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isChange = false;
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

  void saveUserData(User user, String name, String email) {
    final userData = {
      'name' : name, 'email': email
    };
    FirebaseFirestore.instance.collection('fikisha_users').doc(user.uid).set(userData);
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

   Future<void> verifyPhoneNumber() async {
    verificationCompleted(PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      // get the currently signed in user
      User? user = auth.currentUser;
      if(user != null) {
        // store phone number in firetore
        await FirebaseFirestore.instance.
        collection('fikisha_users')
        .doc(user.uid).
        set({'phone_number': user.phoneNumber});
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homeview()),
      );
      }
     else {
      print('User is null');
     }
    }
    verificationFailed(FirebaseAuthException e) {
      // Handle verification failure
      print('Verification failed: ${e.message}');
    }

    codeSent(String verificationId, [int? forceResendingToken]) {
      setState(() {
        verificationId = verificationId;
      });
    }

    codeAutoRetrievalTimeout(String verificationId) {
      setState(() {
        verificationId = verificationId;
      });
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
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
                maxLength: 15,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
              ),              
                const YMargin(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 50,
                    width: context.screenWidth(),
                    decoration: BoxDecoration(
                      color: isChange
                          ? ColorPath.secondarygrey
                          : ColorPath.primaryfield,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(  
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPath.primaryblack
                      ),                   
                      onPressed:
                        () async{
                        await verifyPhoneNumber();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>VerifyOtp(phonenumber: phoneNumberController.text,)));
                        },
                      child: const Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorPath.primarywhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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