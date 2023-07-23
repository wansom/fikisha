import 'package:fikisha/views/Home/home_view.dart';
import 'package:fikisha/views/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
    handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const Homeview();
          } else {
            return const SplashScreen();
          }
        });
  }
}