import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/views/Authentication/user_info.dart';
import 'package:fikisha/utils/colors.dart';

class PasswordVerification extends StatefulWidget {
  const PasswordVerification({Key? key}) : super(key: key);

  @override
  State<PasswordVerification> createState() => _PasswordVerificationState();
}

class _PasswordVerificationState extends State<PasswordVerification> {
  TextEditingController passwordtexteditingcontroller = TextEditingController();
  String code = "";
  bool isChange = false;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      isPasswordEightCharacters = false;
      if (passwordtexteditingcontroller.text.length >= 8) {
        isPasswordEightCharacters = true;
      }

      hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(passwordtexteditingcontroller.text)) {
        hasPasswordOneNumber = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    passwordtexteditingcontroller = TextEditingController();
    passwordtexteditingcontroller.addListener(() {
      final isChange = passwordtexteditingcontroller.text.isNotEmpty;

      setState(() {
        this.isChange = isChange;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    passwordtexteditingcontroller.dispose();
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
              child: Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Secure your account",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorPath.primarydark,
                          fontSize: 23,
                        ),
                      ),
                      YMargin(15),
                      Text("Create your password",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: ColorPath.primarydark,
                            fontSize: 14,
                          )),
                    ],
                  ),
                  const YMargin(35),
                  CustomTextFieldWidget(
                    onChanged: (password) => onPasswordChanged(password),
                    controller: passwordtexteditingcontroller,
                    hideText: true,
                    keyboardType: TextInputType.visiblePassword,
                    autofill: const [AutofillHints.password],
                    hintText: 'Create password',
                  ),
                  const YMargin(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  isPasswordEightCharacters
                                      ? Icons.check
                                      : Icons.cancel_outlined,
                                  color: isPasswordEightCharacters
                                      ? ColorPath.primarygreen
                                      : ColorPath.primaryred,
                                  size: 10.0,
                                ),
                                const XMargin(2),
                                Text(
                                  "8 characters long",
                                  style: TextStyle(
                                    color: isPasswordEightCharacters
                                        ? ColorPath.primarygreen
                                        : ColorPath.primaryred,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9.0,
                                  ),
                                )
                              ],
                            )),
                        const XMargin(10),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  hasPasswordOneNumber
                                      ? Icons.check
                                      : Icons.cancel_outlined,
                                  color: hasPasswordOneNumber
                                      ? Colors.green
                                      : Colors.red,
                                  size: 10.0,
                                ),
                                const XMargin(2),
                                Text(
                                  "Must contain Number",
                                  style: TextStyle(
                                    color: hasPasswordOneNumber
                                        ? ColorPath.primarygreen
                                        : ColorPath.primaryred,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9.0,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  const YMargin(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 50,
                      width: context.screenWidth(),
                      decoration: BoxDecoration(
                        color: isPasswordEightCharacters &&
                                hasPasswordOneNumber &&
                                isChange
                            ? ColorPath.secondarygrey
                            : ColorPath.primaryfield,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: isPasswordEightCharacters && hasPasswordOneNumber
                            ? isChange
                                ? () {
                                    setState(() {
                                      isChange = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const UserInfo(),
                                          ));
                                    });
                                  }
                                : null
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
