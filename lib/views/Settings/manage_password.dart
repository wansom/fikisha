// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/views/Payment/payment.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';

class ManagePassword extends StatefulWidget {
  const ManagePassword({Key? key}) : super(key: key);

  @override
  _ManagePasswordState createState() => _ManagePasswordState();
}

class _ManagePasswordState extends State<ManagePassword> {
  TextEditingController passwordtexteditingcontroller = TextEditingController();
  TextEditingController confirmpasswordtexteditingcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: CustomAppBar(title: "Manage Password"),
      ),
      body: FadeInUp(
        duration: const Duration(milliseconds: 2000),
        child: Column(
          children: [
            const YMargin(50),
            CustomTextFieldWidget(
              controller: passwordtexteditingcontroller,
              hideText: true,
              keyboardType: TextInputType.visiblePassword,
              autofill: const [AutofillHints.password],
              hintText: 'Password',
            ),
            const YMargin(8.0),
            CustomTextFieldWidget(
              controller: confirmpasswordtexteditingcontroller,
              hideText: true,
              keyboardType: TextInputType.visiblePassword,
              autofill: const [AutofillHints.password],
              hintText: 'Confirm Password',
            ),
            const YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 50,
                width: context.screenWidth(),
                decoration: BoxDecoration(
                  color: ColorPath.secondarygrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Password",
                      style: TextStyle(
                        color: ColorPath.primarywhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ).ripple(() {}),
            ),
          ],
        ),
      ),
    );
  }
}
