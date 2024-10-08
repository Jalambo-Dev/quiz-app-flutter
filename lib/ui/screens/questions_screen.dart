import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/models/question_model.dart';
import 'package:quiz_app_flutter/ui/screens/result_screen.dart';
import 'package:quiz_app_flutter/ui/widgets/next_button_widget.dart';
import 'package:quiz_app_flutter/ui/widgets/option_button_widget.dart';
import 'package:quiz_app_flutter/ui/widgets/progress_bar_widget.dart';

class QuestionsScreen extends StatefulWidget {
  final String name;
  const QuestionsScreen({super.key, required this.name});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int _currentIndex = 0;
  QuestionModel _currentQuestion = quizData[0];
  bool isAnswered = false; // Tracks whether the user has answered
  int? selectedIndex; // Tracks the selected answer index
  bool isCorrect = false; // Tracks whether the selected answer is correct
  int score = 0;

  late double _percentage = 0.0;

  void nextQuestion() {
    setState(() {
      if (_currentIndex == 9) {
        getRusult();
      } else {
        _currentIndex++;
        _currentQuestion = quizData[_currentIndex];
        isAnswered = false; // Reset for the next question
        selectedIndex = null; // Clear the selected index
        _percentage += 0.1;
      }
    });
  }

  // Get Score in the result screen
  void getRusult() {
    Navigator.pushReplacement(
        context,
        CupertinoModalPopupRoute(
          builder: (context) => ResultScreen(score: score),
        ));
  }

  // Get first char of name
  String getFirstCharOfName() {
    String fullName = widget.name;
    List<String> nameParts = fullName.split(" ");
    if (nameParts.length == 2) {
      String initials =
          nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
      return initials;
    } else {
      String initials = nameParts[0][0].toUpperCase();
      return initials;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Welcome in Flutter Quiz'),
        backgroundColor: Colors.black,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              getFirstCharOfName(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Index of question
                    Text(
                      'Question ${_currentQuestion.id}/10',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    // Progress Bar
                    ProgressBarWidget(
                      width: MediaQuery.of(context).size.width,
                      heigth: 2,
                      progress: _percentage,
                    ),

                    const SizedBox(height: 18),

                    // Question
                    Text(
                      _currentQuestion.question,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    ),

                    const SizedBox(height: 18),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _currentQuestion.options.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Check if this option is selected
                        bool isSelected = selectedIndex == index;
                        // Check if this is the correct option
                        bool isCorrectOption =
                            index == _currentQuestion.answerIndex;

                        return OptionButtonWidget(
                          text: _currentQuestion.options[index],
                          backgroundColor: isAnswered
                              ? (isSelected
                                  ? (isCorrect
                                      ? Colors.green.shade400
                                      : Colors.red.shade400)
                                  : isCorrectOption
                                      ? Colors.green.shade400
                                      : Colors.black45)
                              : Colors.black45,
                          onTap: !isAnswered // Allow taps only if not answered
                              ? () {
                                  setState(() {
                                    selectedIndex =
                                        index; // Update selected index
                                    isAnswered =
                                        true; // Mark the question as answered
                                    isCorrect =
                                        isCorrectOption; // Check if selected option is correct
                                    if (isCorrect) {
                                      log("Correct Answer");
                                      score++;
                                    } else {
                                      log("Incorrect Answer");
                                    }
                                  });
                                }
                              : null, // Disable onTap if already answered
                          visible: true, // Ensure icon is visible
                          iconData: isAnswered
                              ? (isSelected
                                  ? (isCorrect
                                      ? Icons.check_circle
                                      : Icons.cancel)
                                  : (isCorrectOption
                                      ? Icons.check_circle
                                      : Icons.circle))
                              : Icons.circle_outlined,
                          iconDataColor: isAnswered
                              ? (isSelected
                                  ? (isCorrect
                                      ? Colors.green.shade900
                                      : Colors.red.shade900)
                                  : (isCorrectOption
                                      ? Colors.green.shade900
                                      : Colors.transparent))
                              : Colors.transparent,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Button to go to the next question at the bottom
            Visibility(
              visible: isAnswered,
              replacement: NextButtonWidget(
                onPressed: nextQuestion,
                text: 'Skip',
              ),
              child: NextButtonWidget(
                onPressed: nextQuestion,
                text: 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
