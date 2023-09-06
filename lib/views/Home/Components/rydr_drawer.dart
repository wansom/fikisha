// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:fikisha/views/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
// import 'package:fikisha/views/Home/Components/home_extention.dart';
// import 'package:fikisha/views/Notifications/notifications.dart';
// import 'package:fikisha/views/Payment/Coupons/apply_coupons.dart';
// import 'package:fikisha/views/Payment/payment.dart';
// import 'package:fikisha/views/Settings/manage_password.dart';
// import 'package:fikisha/views/Support/support.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/views/TripHistory/trip_screen.dart';

class RyderDrawer extends StatefulWidget {
  const RyderDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<RyderDrawer> createState() => _RyderDrawerState();
}

class _RyderDrawerState extends State<RyderDrawer> {
  final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      margin: const EdgeInsets.only(right: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Image(
                      width: 110,
                      height: 110,
                      image: AssetImage(ImagesAsset.logosm),
                    ),
                      ),
                      const YMargin(14),
                    //   Padding(
                    // padding: const EdgeInsets.symmetric(horizontal: 50),
                    // child: Container(
                    //   height: 33,
                    //   width: 125,
                    //   decoration: BoxDecoration(
                    //     color: ColorPath.primarydark,
                    //     borderRadius: BorderRadius.circular(8.0),
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Edit Profile",
                    //           style: TextStyle(
                    //             color: ColorPath.primarywhite,
                    //             fontSize: 10.0,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ).ripple(() {}),
                    //   ),
                    ]),
                  ],
                ),
                const YMargin(10),
                const DrawerDots(
                  dashColor: ColorPath.primaryfield,
                  dashHeight: 1.0,
                  dashWidth: 2.0,
                ),
                const YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(children: [
                    DrawerListTile(
                      title: 'Your Delivery History',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TripScreen(),
                            ));
                      },
                    ),
                    // DrawerListTile(
                    //   title: 'Payment',
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const Payments(),
                    //         ));
                    //   },
                    // ),
                    // DrawerListTile(
                    //   title: 'Notifications',
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const Notifications(),
                    //         ));
                    //   },
                    // ),
                    // DrawerListTile(
                    //   title: 'Apply Coupon',
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => ApplyCoupon(),
                    //         ));
                    //   },
                    // ),
                    // DrawerListTile(
                    //   title: 'Support',
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const Support(),
                    //         ));
                    //   },
                    // ),
                    // DrawerListTile(
                    //   title: 'Manage Password',
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const ManagePassword(),
                    //         ));
                    //   },
                    // ),
                    // DrawerListTile(
                    //   title: 'About us',
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => ChatWithDriver(),
                    //         ));
                    //   },
                    // ),
                  ]),
                ),
                const Spacer(),
                const DrawerDots(
                  dashColor: ColorPath.primaryfield,
                  dashHeight: 1.0,
                  dashWidth: 2.0,
                ),
                const YMargin(10),
                // const Text("Share on:",
                //     style: TextStyle(
                //       fontSize: 10.0,
                //       fontWeight: FontWeight.w400,
                //       color: ColorPath.primarydark,
                //     )),
                // const YMargin(10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 25,
                //       width: 25,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: AssetImage(ImagesAsset.whatsapp))),
                //     ),
                //     const XMargin(5),
                //     Container(
                //       height: 25,
                //       width: 25,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: AssetImage(ImagesAsset.twitter))),
                //     ),
                //     const XMargin(5),
                //     Container(
                //       height: 25,
                //       width: 25,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: AssetImage(ImagesAsset.facebook))),
                //     ),
                //   ],
                // ),
                const YMargin(10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPath.primaryred,
                  ),
                  onPressed: () async{                    
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                      );
                  }, 
                  child: const Text(
                    'Log out'
                  )
                  ),
                const YMargin(10),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: ColorPath.primarydark,
          )),
    );
  }
}

class DrawerDots extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DrawerDots({
    this.totalWidth = 150,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}