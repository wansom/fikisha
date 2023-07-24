import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/utils/colors.dart';

class ChooseAuth extends StatelessWidget {
  const ChooseAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPath.primarywhite,
        body: SafeArea(
            child: FadeInDown(
          duration: const Duration(milliseconds: 3000),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(40),
                authHeader(context),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enjoy a new  \n Delivery experience",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPath.primarydark,
                          fontSize: 26,
                        ),
                      ),
                      YMargin(5.0),
                      Text(
                        "Amazing Experience with top notch \nrider services",
                        style: TextStyle(
                          color: ColorPath.primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const YMargin(40),
                Column(
                  children: [
                    // AuthButtons(
                    //   color: ColorPath.primarydark,
                    //   text: "Continue with Email",
                    //   icon: ImagesAsset.envelope,
                    //   textcolor: ColorPath.primarywhite,
                    //   bordercolor: Colors.transparent,
                    // ),
                    // const YMargin(10),
                    // AuthButtons(
                    //   color: ColorPath.primarywhite,
                    //   text: "Continue with Google",
                    //   icon: ImagesAsset.google,
                    //   textcolor: ColorPath.secondarydark,
                    //   bordercolor: ColorPath.secondarydark,
                    // ),
                    // const YMargin(10),
                    // AuthButtons(
                    //   color: ColorPath.primaryblue,
                    //   text: "Continue with Facebook",
                    //   icon: ImagesAsset.facebookb,
                    //   textcolor: ColorPath.primarywhite,
                    //   bordercolor: Colors.transparent,
                    // ),
                    const YMargin(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MobileAuth()));
                      },
                      child: AuthButtons(
                      color: ColorPath.primarydark,
                      // text: "Continue with Email",
                      // icon: ImagesAsset.envelope,
                      text: "Continue with Phone Number",
                      icon: ImagesAsset.call,
                      textcolor: ColorPath.primarywhite,
                      bordercolor: Colors.transparent,
                    ),
                    )
                  ],
                ),
                const YMargin(100),
                Container(
                  alignment: Alignment.center,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "By continuing, you are acknowledging \nour ",
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorPath.primaryColor,
                          ),
                        ),
                        TextSpan(
                            text: "terms ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                          text: "and ",
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorPath.primaryColor,
                          ),
                        ),
                        TextSpan(
                            text: "privacy policy",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                ),
                // const YMargin(40),
                // Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Text("Have an account?",
                //           style: TextStyle(
                //             fontSize: 13,
                //             color: Colors.black,
                //             fontWeight: FontWeight.w300,
                //           )),
                //       const XMargin(5.0),
                //       InkWell(
                //         onTap: () {
                //           Navigator.pushReplacement(
                //               context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                //         },
                //         child: const Text("Sign in",
                //             style: TextStyle(
                //               fontSize: 13,
                //               color: Colors.black,
                //               fontWeight: FontWeight.bold,
                //             )),
                //       )
                //     ],
                //   ),
                // )
              ]),
        )));
  }
}

// ignore: must_be_immutable
class AuthButtons extends StatelessWidget {
  final Color color;
  final String text;
  final String icon;
  final Color textcolor;
  Function? ontap;
  final Color bordercolor;

  AuthButtons({
    required this.color,
    required this.text,
    required this.icon,
    required this.textcolor,
    required this.bordercolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 50,
        width: context.screenWidth(),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: bordercolor,
            )),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const MobileAuth()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textcolor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const XMargin(7.0),
              SvgPicture.asset(icon),
            ],
          ),
        ),
      ),
    );
  }
}
