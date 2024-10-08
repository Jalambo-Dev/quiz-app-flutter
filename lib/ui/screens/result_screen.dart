import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/questions_screen.dart';
import 'package:quiz_app_flutter/ui/screens/welcome_screen.dart';
import 'package:quiz_app_flutter/ui/widgets/next_button_widget.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score', style: Theme.of(context).textTheme.displaySmall),
            Text(
              "${score.toString()}/10",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(64, 64),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  )),
              child: const Icon(CupertinoIcons.arrow_clockwise),
            )
          ],
        ),
      ),
    );
  }
}
