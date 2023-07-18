// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/models/onboard_model.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoarding', isViewed);
    print(prefs.getInt('onBoarding'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPath.primarywhite,
        body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                const YMargin(80),
                Container(
                  width: context.screenWidth(),
                  height: 45,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(ImagesAsset.logosm))),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(ImagesAsset.citybg))),
                    ),
                    const YMargin(10),
                    PageView.builder(
                        itemCount: screens.length,
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (int index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              const YMargin(220),
                              Column(
                                children: [
                                  Container(
                                    width: 320,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                screens[index].img))),
                                  ),
                                  const YMargin(5),
                                  Text(
                                    screens[index].text,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: ColorPath.secondaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.3,
                                    ),
                                  ),
                                  const YMargin(10),
                                  Text(
                                    screens[index].desc,
                                    textAlign: TextAlign.center,
                                    maxLines: 5,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      color: ColorPath.primarywhite,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.6,
                                    ),
                                  ),
                                  const YMargin(20),
                                ],
                              ),
                            ],
                          );
                        }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: SizedBox(
                          height: 10.0,
                          child: ListView.builder(
                            itemCount: screens.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 3.0),
                                      width: 45,
                                      height: 1.5,
                                      decoration: BoxDecoration(
                                        color: currentIndex == index
                                            ? ColorPath.primarydark
                                            : const Color(0xFFEBEBEB),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ]);
                            },
                          ),
                        ),
                      ),
                    ),
                    const YMargin(30),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            currentIndex != 2
                                ? InkWell(
                                  onTap: () {
                                    _storeOnboardInfo();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MobileAuth()));
                                  },
                                  child: Container(
                                    height: 52,
                                    width: 93,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                        color: ColorPath.primarydark),
                                    child: const Center(
                                      child: Text(
                                        "Skip",
                                        style: TextStyle(
                                            color: ColorPath.primarywhite),
                                      ),
                                    ),
                                  ),
                                )
                                : const SizedBox(
                                    height: 52,
                                    width: 93,
                                  ),
                            const XMargin(50),
                            InkWell(
                              onTap: () async {
                                if (currentIndex == screens.length - 1) {
                                  await _storeOnboardInfo();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MobileAuth()));
                                }
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                height: 61,
                                width: 61,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorPath.primarydark),
                                child: Center(
                                    child: SvgPicture.asset(
                                        ImagesAsset.rightarrow)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            )));
  }
}
