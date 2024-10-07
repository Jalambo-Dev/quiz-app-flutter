import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/models/question_model.dart';
import 'package:quiz_app_flutter/ui/screens/result_screen.dart';
import 'package:quiz_app_flutter/ui/widgets/next_button_widget.dart';
import 'package:quiz_app_flutter/ui/widgets/option_button_widget.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

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

  void nextQuestion() {
    setState(() {
      if (_currentIndex == 9) {
        getRusult();
      } else {
        _currentIndex++;
        _currentQuestion = quizData[_currentIndex];
        isAnswered = false; // Reset for the next question
        selectedIndex = null; // Clear the selected index
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // Index of question
              Text(
                'Question ${_currentQuestion.id}/10',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const Divider(thickness: 1.5),

              // Question
              Text(
                _currentQuestion.question,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),

              const SizedBox(height: 36),

              ListView.builder(
                shrinkWrap: true,
                itemCount: _currentQuestion.options.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  // Check if this option is selected
                  bool isSelected = selectedIndex == index;
                  // Check if this is the correct option
                  bool isCorrectOption = index == _currentQuestion.answerIndex;

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
                            setState(
                              () {
                                selectedIndex = index; // Update selected index
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
                              },
                            );
                          }
                        : null, // Disable onTap if already answered
                    visible: true, // Ensure icon is visible
                    iconData: isAnswered
                        ? (isSelected
                            ? (isCorrect ? Icons.check_circle : Icons.cancel)
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
              const Spacer(),

              // Button to go to the next question
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
      ),
    );
  }
}
