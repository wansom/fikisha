// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class OnboardingTile extends StatelessWidget {
  final image, description, title;

  const OnboardingTile({super.key,this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 100,),
          Image.asset(image,
          height: 110,),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}
