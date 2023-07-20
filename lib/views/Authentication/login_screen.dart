// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/views/Home/home_view.dart';
import 'package:fikisha/utils/colors.dart';

import 'components/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailnametexteditingcontroller =
      TextEditingController();
  TextEditingController passwordnametexteditingcontroller =
      TextEditingController();
  String code = "";
  bool isChange = false;

  @override
  void initState() {
    super.initState();
    emailnametexteditingcontroller = TextEditingController();
    passwordnametexteditingcontroller = TextEditingController();

    passwordnametexteditingcontroller.addListener(() {
      final isChange = passwordnametexteditingcontroller.text.isNotEmpty &&
          passwordnametexteditingcontroller.text.isNotEmpty;
      setState(() {
        this.isChange = isChange;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    passwordnametexteditingcontroller.dispose();
    emailnametexteditingcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPath.primarywhite,
        body: SingleChildScrollView(
          child: Column(children: [
            const YMargin(100),
            authHeader(context),
            Column(
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 1400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back To Fikisha",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorPath.primarydark,
                                fontSize: 18,
                              ),
                            ),
                            YMargin(7),
                            Text("Enjoy awesome deliveries at cheap rates",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: ColorPath.primarydark,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                      const YMargin(30),
                      TextField(
                        controller: emailnametexteditingcontroller,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: const InputDecoration(
                          hintText: 'Email Address',
                        ),
                      ),
                      const YMargin(10),
                      TextField(
                        controller: passwordnametexteditingcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,                       
                        autofillHints: const [AutofillHints.password],
                        decoration: const InputDecoration(
                          hintText: 'Password', 
                        suffix: Text("show"),
                        ),
                      ),
                      const YMargin(20),
                      FadeInDown(
                        duration: const Duration(milliseconds: 1600),
                        child: Padding(
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
                            child: InkWell(
                              onTap: isChange
                                  ? () {
                                      setState(() {
                                        isChange = false;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const Homeview(),
                                            ));
                                      });
                                    }
                                  : null,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      color: ColorPath.primarywhite,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const YMargin(40),
                FadeInDown(
                  duration: const Duration(milliseconds: 2000),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        height: 50,
                        width: context.screenWidth() - 180,
                        decoration: BoxDecoration(
                            color: ColorPath.primarywhite,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: const Color(0xFF90D8FF),
                            )),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Homeview()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    color: ColorPath.secondarydark,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const XMargin(7.0),
                                SvgPicture.asset(ImagesAsset.google),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const XMargin(8),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorPath.primaryblue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset(ImagesAsset.facebookb,
                              height: 14, width: 9)),
                    ),
                    const XMargin(8),
                    InkWell(
                      onTap: ()  {
                        // final isAuthenticated =
                        //     await LocalAuthApi.authenticate();

                        // if (isAuthenticated) {
                        //   Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (context) => const Homeview()),
                        //   );
                        // }
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const Homeview()),
                          );
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorPath.primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset(
                            !Platform.isIOS
                                ? ImagesAsset.finger
                                : ImagesAsset.faceid,
                            height: 14,
                            width: 9,
                          )),
                    ),
                  ]),
                ),
                const YMargin(40),
                FadeInDown(
                  duration: const Duration(milliseconds: 2200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          )),
                      const XMargin(5.0),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const MobileAuth()),
                          );
                        },
                        child: const Text("Sign up",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  Widget buildText(String text, bool checked) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? const Icon(Icons.check, color: Colors.green, size: 24)
                : const Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () {
          // final isAuthenticated = await LocalAuthApi.authenticate();

          // if (isAuthenticated) {
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => const Homeview()),
          //   );
          // }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Homeview()));
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
