import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Payment/payment.dart';
import 'package:fikisha/utils/colors.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Notification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const YMargin(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: ColorPath.primarydark,
                    ),
                    child: const Center(
                      child: Text(
                        "10th June 2023",
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.w300,
                          color: ColorPath.secondaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 2000),
              child: SizedBox(
                height: context.screenHeight(),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return notificationCard(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget notificationCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
        height: 65,
        width: context.screenWidth(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: ColorPath.primaryfield,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image(image: AssetImage(ImagesAsset.logosm)),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Free Coupons ",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: ColorPath.primarydark,
                  ),
                ),
                YMargin(5),
                Text(
                  "Hello, You can get free Coupons for your next trip by referring us!",
                  style: TextStyle(
                    fontSize: 7.0,
                    fontWeight: FontWeight.w300,
                    color: ColorPath.primarydark,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
