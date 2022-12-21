import 'package:digitalfarming/views/splash/splash_body.dart';
import 'package:digitalfarming/views/splash/splash_header.dart';
import 'package:flutter/material.dart';

class SplashCard extends StatelessWidget {
  const SplashCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SplashHeader(),
        SizedBox(
          height: 100,
        ),
        SplashBody(),
      ],
    );
  }
}
