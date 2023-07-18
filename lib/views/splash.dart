// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? isviewed;

  Future getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    isviewed = prefs.getInt('onBoarding');
  }

  @override
  void initState() {
    super.initState();
    getAuth();
    Timer(
        const Duration(milliseconds: 2500),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return isviewed != 0 ? const Onboarding() : const Onboarding();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          FadeIn(
            duration: const Duration(milliseconds: 1500),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 106,
                height: 33,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ImagesAsset.splash),
                )),
              ),
            ),
          ),
          const Spacer(),
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 83,
                height: 83,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ImagesAsset.ripple),
                )),
              ),
            ),
          ),
          const YMargin(40)
        ],
      ),
    );
  }
}
