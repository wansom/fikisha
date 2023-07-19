// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:fikisha/views/Authentication/verify_otp.dart';
import 'package:fikisha/views/Home/home_page.dart';
import 'package:fikisha/views/Home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:pinput/pinput.dart';

class MobileAuth extends StatefulWidget {
  const MobileAuth({Key? key}) : super(key: key);

  @override
  _MobileAuthState createState() => _MobileAuthState();
}

class _MobileAuthState extends State<MobileAuth> {
  TextEditingController phoneNumberController = TextEditingController();
  String _verificationId = '';
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

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

    Future<void> verifyPhoneNumber() async {
    verificationCompleted(PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      // Authentication successful, navigate to the home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
    verificationFailed(FirebaseAuthException e) {
      // Handle verification failure
      print('Verification failed: ${e.message}');
    }

    codeSent(String verificationId, [int? forceResendingToken]) {
      setState(() {
        _verificationId = verificationId;
      });
    }

    codeAutoRetrievalTimeout(String verificationId) {
      setState(() {
        _verificationId = verificationId;
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
                      onPressed:
                        () {
                        verifyPhoneNumber();
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

  void signInWithPhoneNumber() async{
      try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: pinPutController.text,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // Authentication successful, navigate to the home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homeview()),
      );
    } catch (e) {
      // Handle sign-in failure
      print('Sign-in failed: $e');
    }
  }
  }

class CustomTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofill;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool hideText;
  final Color fillcolour;
  final Function(String)? onChanged;

  const CustomTextFieldWidget(
      {Key? key,
      required this.controller,
      this.hintText = 'A Text is missing HERE!',
      this.keyboardType,
      this.autofill,
      this.prefixWidget,
      this.hideText = false,
      this.suffixWidget,
      this.fillcolour = ColorPath.primaryfield,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      child: TextField(
        onChanged: onChanged,
        obscureText: hideText,
        controller: controller,
        cursorColor: ColorPath.primaryblack,
        keyboardType: keyboardType,
        autofillHints: autofill,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          prefix: prefixWidget,
          filled: true,
          fillColor: fillcolour,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: Color(0xFFd4f0ff),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: ColorPath.primaryfield,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xFF77869E),
          ),
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final dropdownValue;
  final List items;
  final Function(String? value)? onChanged;
  final Color backgroundColour;

  const CustomDropdown({
    Key? key,
    this.dropdownValue,
    required this.items,
    this.onChanged,
    this.backgroundColour = ColorPath.primarywhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 45,
      decoration: BoxDecoration(
        color: backgroundColour,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFF0647b0),
          width: 0.1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          items: items
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class NumericPad extends StatelessWidget {
  final Function(int) onNumberSelected;
  final Function(bool)? onValidate;

  const NumericPad({super.key, 
    required this.onNumberSelected,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE7E8E7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberContainer(1),
                  numberContainer(2),
                  numberContainer(3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberContainer(4),
                  numberContainer(5),
                  numberContainer(6),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  numberContainer(7),
                  numberContainer(8),
                  numberContainer(9),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildBackspace(),
                  numberContainer(0),
                  validateContainer(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget numberContainer(int number) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
              color: Color(0xFF41536C),
            ),
          ),
        ),
      ).ripple(
        () {
          onNumberSelected(number);
        },
      ),
    ));
  }

  Widget buildBackspace() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          decoration: const BoxDecoration(
            color: Color(0xffF7F9FD),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.backspace,
              size: 28,
              color: ColorPath.offWhite,
            ),
          ),
        ).ripple(
          () {
            onNumberSelected(-1);
          },
        ),
      ),
    );
  }

  Widget validateContainer(context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        decoration: const BoxDecoration(
          color: ColorPath.primarydark,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_forward,
            size: 28,
            color: ColorPath.primarywhite,
          ),
        ),
      ).ripple(() {
        onValidate!(true);
      }),
    ));
  }

  Widget emptyContainer(context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    ));
  }
}
