import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/components/auth_header.dart';
import 'package:fikisha/views/Authentication/user_details.dart';
import 'package:fikisha/utils/colors.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController emailtexteditingcontroller = TextEditingController();
  String code = "";
  bool isChange = false;
  bool isValid = false;

  onEmailChange(String email) {
    final numericRegex = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
    setState(() {
      isValid = false;
      if (numericRegex.hasMatch(emailtexteditingcontroller.text)) {
        isValid = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    emailtexteditingcontroller = TextEditingController();
    emailtexteditingcontroller.addListener(() {
      final isChange = emailtexteditingcontroller.text.isNotEmpty;

      setState(() {
        this.isChange = isChange;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailtexteditingcontroller.dispose();
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
              child: Column(
                children: [
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
                      Text("What is your email address?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: ColorPath.primarydark,
                            fontSize: 14,
                          )),
                      YMargin(3.0),
                      Text("Make sure you enter a correct Email Address",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorPath.primaryColor,
                            fontSize: 9.0,
                          )),
                    ],
                  ),
                  const YMargin(25),
                  TextField(
                    onChanged: (password) => onEmailChange(password),
                    controller: emailtexteditingcontroller,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  const YMargin(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 50,
                      width: context.screenWidth(),
                      decoration: BoxDecoration(
                        color: isValid && isChange
                            ? ColorPath.secondarygrey
                            : ColorPath.primaryfield,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: isValid
                            ? isChange
                                ? () {
                                    setState(() {
                                      isChange = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UserVerification(),
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
