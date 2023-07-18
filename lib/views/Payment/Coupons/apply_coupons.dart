import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Payment/payment.dart';
import 'package:fikisha/utils/colors.dart';

class ApplyCoupon extends StatelessWidget {
  final TextEditingController coupontextEditingController =
      TextEditingController();
  ApplyCoupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Apply Coupons"),
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          duration: const Duration(milliseconds: 2000),
          child: Column(
            children: [
              const YMargin(20),
              CustomTextFieldWidget(
                controller: coupontextEditingController,
                keyboardType: TextInputType.text,
                autofill: const [AutofillHints.name],
                hintText: 'Enter Coupon Code',
              ),
              const YMargin(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  height: 50,
                  width: context.screenWidth(),
                  decoration: BoxDecoration(
                    color: ColorPath.secondarygrey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Apply Coupon Code",
                          style: TextStyle(
                            color: ColorPath.primarywhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).ripple(() {}),
              ),
              const YMargin(20),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Active Coupons",
                            style: TextStyle(
                              color: Color(0xFF818181),
                              fontSize: 9,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              const YMargin(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    height: 120,
                    width: context.screenWidth(),
                    decoration: BoxDecoration(
                        color: ColorPath.goldenColor,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: ColorPath.primarydark.withOpacity(0.3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage(ImagesAsset.ride)),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "🎉Congratulations!",
                              style: TextStyle(
                                color: ColorPath.primarydark,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            YMargin(10),
                            Text(
                              "You have gotten 10% free Coupon \nfor our next trip.",
                              style: TextStyle(
                                color: ColorPath.primarywhite,
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              const YMargin(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    height: 120,
                    width: context.screenWidth(),
                    decoration: BoxDecoration(
                      color: const Color(0XFF878E88),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage(ImagesAsset.cough)),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "😱10 Trips  Coupon!",
                              style: TextStyle(
                                color: ColorPath.primarydark,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            YMargin(10),
                            Text(
                              "Get 60% off your next trip due to the \nwith coupon!",
                              style: TextStyle(
                                color: ColorPath.primarywhite,
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
