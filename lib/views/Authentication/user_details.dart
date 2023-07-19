import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/create_password.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/utils/colors.dart';
import 'components/auth_header.dart';

class UserVerification extends StatefulWidget {
  const UserVerification({Key? key}) : super(key: key);

  @override
  State<UserVerification> createState() => _UserVerificationState();
}

class _UserVerificationState extends State<UserVerification> {
  TextEditingController firstnametexteditingcontroller =
      TextEditingController();
  TextEditingController lastnametexteditingcontroller = TextEditingController();
  String code = "";
  bool isChange = false;

  @override
  void initState() {
    super.initState();
    firstnametexteditingcontroller = TextEditingController();
    lastnametexteditingcontroller = TextEditingController();

    lastnametexteditingcontroller.addListener(() {
      final isChange = lastnametexteditingcontroller.text.isNotEmpty &&
          lastnametexteditingcontroller.text.isNotEmpty;
      setState(() {
        this.isChange = isChange;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    lastnametexteditingcontroller.dispose();
    firstnametexteditingcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPath.primarywhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const YMargin(100),
            authHeader(context),
            FadeInDown(
                duration: const Duration(milliseconds: 2000),
                child: Column(children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let’s know you",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorPath.primarydark,
                          fontSize: 23,
                        ),
                      ),
                      YMargin(10),
                      Text("Please enter your correct names for identification",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: ColorPath.primarydark,
                            fontSize: 14,
                          )),
                    ],
                  ),
                  const YMargin(25),
                  CustomTextFieldWidget(
                    controller: firstnametexteditingcontroller,
                    keyboardType: TextInputType.name,
                    autofill: const [AutofillHints.name],
                    hintText: 'First name',
                  ),
                  const YMargin(10),
                  CustomTextFieldWidget(
                    controller: lastnametexteditingcontroller,
                    keyboardType: TextInputType.name,
                    autofill: const [AutofillHints.name],
                    hintText: 'Last name',
                  ),
                  const YMargin(30),
                  Padding(
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
                                        builder: (context) =>
                                            const PasswordVerification(),
                                      ));
                                });
                              }
                            : null,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next",
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
                ])),
          ],
        ),
      ),
    );
  }
}
