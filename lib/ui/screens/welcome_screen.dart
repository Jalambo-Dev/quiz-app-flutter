import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                // Get Started Title Text
                Text(
                  "Let's Play Quiz!",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                // Get Started subTitle Text
                Text(
                  "Ready to test your knowledge?\nChoose a quiz, challenge yourself, and have fun!\nEnter your name below!",
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                const SizedBox(height: 18),

                // Name Text Filed
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                const Spacer(),

                // Let's Start Quiz Button
                // const OptionButtonWidget(
                //   text: 'GetStarted',
                //   textColor: Color(0xff071952),
                //   fontWeight: FontWeight.bold,
                //   backgroundColor: Color(0xff35A29F),
                // ),
                const SizedBox(height: 32.0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
