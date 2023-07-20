// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/utils/colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phonetextEditingController = TextEditingController();

  String code = "";

  bool isChange = false;

  @override
  void initState() {
    super.initState();
    phonetextEditingController = TextEditingController();
    phonetextEditingController.addListener(() {
      final isChange = phonetextEditingController.text.isNotEmpty;
      setState(() {
        this.isChange = isChange;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    phonetextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPath.primarywhite,
        body: SingleChildScrollView(
          child: Column(children: [
            const YMargin(100),
            authHeader(context),
            FadeInDown(
              child: Column(
                children: [
                  Column(
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
                              "Forget Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorPath.primarydark,
                                fontSize: 18,
                              ),
                            ),
                            YMargin(10),
                            Text(
                                "Did you forget your password? You can easily retrive it \nby telling us your mobile number!",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ColorPath.primarydark,
                                  fontSize: 10,
                                )),
                          ],
                        ),
                      ),
                      const YMargin(50),
                      TextField(
                        controller: phonetextEditingController,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumberAreaCode],
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                        prefix: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                                alignedDropdown: true,
                                child: const Text("+254 |  "))),
                        ),
                      ),
                      const YMargin(20),
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
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => (),
                                      //     ));
                                    });
                                  }
                                : null,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Submit",
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
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
