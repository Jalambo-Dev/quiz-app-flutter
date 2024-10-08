import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/questions_screen.dart';
import 'package:quiz_app_flutter/ui/widgets/next_button_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String name = '';
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Get Started Title Text
                      Text(
                        "Let's Play Quiz!",
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),

                      // Get Started subTitle Text
                      Text(
                        "Ready to test your knowledge?\nChoose a quiz, challenge yourself, and have fun!",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 18),

                      // Name Text Filed
                      TextField(
                        controller: textEditingController,
                        cursorColor: Colors.black,
                        onChanged: (value) => setState(() => name = value),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14.5),
                          hintText: "Enter your name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red.shade400),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36.0),
                    ],
                  ),
                ),
              ),
            ),
            NextButtonWidget(
              onPressed: () {
                if (name.isNotEmpty) {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => QuestionsScreen(name: name),
                    ),
                  );
                } else {
                  // Show a message if the user hasn't entered a name
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        duration: Duration(milliseconds: 800),
                        content: Text('Please enter your name')),
                  );
                }
              },
              text: 'Get Started',
            ),
            const SizedBox(height: 18)
          ],
        ),
      ),
    );
  }
}
