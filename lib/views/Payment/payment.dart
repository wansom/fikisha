// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/utils/colors.dart';
import 'add_payment_method.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  TextEditingController coupontextEditingController = TextEditingController();
  String? payment = "cash";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Payment"),
      ),
      body: Column(
        children: [
          const YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 1800),
                  child: Container(
                    width: 340,
                    height: 122,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPath.primarydark,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImagesAsset.paybg),
                        )),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Fikisha Balance",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: ColorPath.secondaryColor,
                          ),
                        ),
                        YMargin(10),
                        Text(
                          "Ksh13,300",
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w600,
                            color: ColorPath.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const YMargin(30),
          FadeInUp(
            duration: const Duration(milliseconds: 2000),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "Payment Methods",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: ColorPath.primarydark,
                        ),
                      ),
                    ],
                  ),
                ),
                const YMargin(20),
                Container(
                  height: 85,
                  width: context.screenWidth(),
                  decoration: const BoxDecoration(color: ColorPath.primarydark),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const XMargin(20),
                          SvgPicture.asset(ImagesAsset.money1),
                          const XMargin(10),
                          const Text(
                            "Pay with Cash",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: ColorPath.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: ColorPath.secondaryColor,
                            value: "cash",
                            onChanged: (value) {
                              setState(() {
                                payment = value.toString();
                              });
                            },
                            groupValue: payment,
                          ),
                          const XMargin(20),
                        ],
                      ),
                    ],
                  ),
                ),
                const YMargin(15),
                Container(
                  height: 52,
                  width: context.screenWidth(),
                  decoration: const BoxDecoration(color: ColorPath.primaryfield),
                  child: Row(
                    children: [
                      const XMargin(20),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: ColorPath.primarydark,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 15,
                          color: ColorPath.primaryfield,
                        ),
                      ),
                      const XMargin(10),
                      const Text(
                        "Add Payment Method",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: ColorPath.primarydark,
                        ),
                      ),
                    ],
                  ),
                ).ripple(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddPaymethod()));
                }),
                const YMargin(20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "Apply Coupon",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: ColorPath.primarydark,
                        ),
                      ),
                    ],
                  ),
                ),
                const YMargin(10),
                TextField(
                  controller: coupontextEditingController,
                  keyboardType: TextInputType.text,
                  autofillHints: const [AutofillHints.name],
                  decoration: const InputDecoration(
                    hintText: 'Enter Coupon Code',
                  ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // brightness: Brightness.dark,
        backgroundColor: ColorPath.primarydark,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 67,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: ColorPath.primarywhite,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                  color: ColorPath.primaryfield,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: const Center(
                  child: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: ColorPath.primarydark,
              )),
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light);
  }
}
