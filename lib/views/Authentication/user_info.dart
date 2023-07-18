import 'package:animate_do/animate_do.dart';
import 'package:fikisha/views/Home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/forget_password.dart';
import 'package:fikisha/utils/colors.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPath.primarywhite,
      body: FadeInDown(
        duration: const Duration(milliseconds: 2000),
        child: Column(children: [
          const YMargin(100),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 105,
              height: 33,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(ImagesAsset.logosm),
                ),
              ),
            ),
          ),
          const YMargin(30),
          Stack(
            children: [
              Container(
                width: context.screenWidth(),
                height: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          ImagesAsset.authimage1,
                        ))),
              ),
              Positioned(
                top: 80,
                left: context.screenWidth() / 3.5 + 10,
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImagesAsset.useravatar))),
                ),
              ),
              Positioned(
                top: 190,
                left: context.screenWidth() / 2 - 15,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: ColorPath.primarywhite,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
          const YMargin(15),
          const Text("Upload clear image of youself,\nlet’s identify you",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: ColorPath.primarydark,
                fontSize: 14,
              )),
          const YMargin(25),
          const Text(
            " Set your Home Address and \nfavourite locations",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorPath.primarydark,
              fontSize: 23,
            ),
          ),
          const YMargin(20),
          favoritecard(
            "🏀",
            "Set your Favoutite Locations",
            "Save more time when booking ride",
          ),
          const YMargin(10),
          favoritecard(
            "🏠",
            "Set your Home Address",
            "Quick access to your home address",
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => ForgetPassword(),
                //         ));
                //   },
                //   child: Container(
                //     width: 110,
                //     height: 30,
                //     decoration: BoxDecoration(
                //       color: ColorPath.Primaryfield,
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //     child: Center(
                //       child: Text(
                //         "Reset Password",
                //         style: GoogleFonts.montserrat(
                //           fontWeight: FontWeight.w300,
                //           color: ColorPath.Primarydark,
                //           fontSize: 12,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ));
                  },
                  child: Container(
                    width: 110,
                    height: 30,
                    decoration: BoxDecoration(
                      color: ColorPath.primaryfield,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: ColorPath.primarydark,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const LoginScreen(),
                  //       ));
                  // },
                  child: Container(
                    width: 110,
                    height: 30,
                    decoration: BoxDecoration(
                      color: ColorPath.primarydark,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: ColorPath.primarywhite,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }

  Widget favoritecard(String image, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: ColorPath.primaryfield,
            border: Border.all(
              width: 0.5,
              color: ColorPath.primaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: ColorPath.primarydark.withOpacity(0.29),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        image,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const XMargin(5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorPath.primarydark,
                            fontSize: 12,
                          )),
                      Text(text2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorPath.primaryColor,
                            fontSize: 10,
                          )),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: ColorPath.primarydark,
              ),
            ],
          )),
    );
  }
}
