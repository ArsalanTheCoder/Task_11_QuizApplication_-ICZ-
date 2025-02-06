import 'package:flutter/material.dart';
import 'UserQuizListScreen.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultsScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage score
    final double percentage = (score / totalQuestions) * 100;

    // Determine the result emoji and message based on the score
    String resultEmoji;
    String resultMessage;
    Color resultColor;

    if (percentage >= 90) {
      resultEmoji = "🎉";
      resultMessage = "Amazing! You're a quiz master!";
      resultColor = Colors.green;
    } else if (percentage >= 70) {
      resultEmoji = "👍";
      resultMessage = "Great job! You did well!";
      resultColor = Colors.blue;
    } else if (percentage >= 50) {
      resultEmoji = "😊";
      resultMessage = "Not bad! Keep practicing!";
      resultColor = Colors.orange;
    } else {
      resultEmoji = "😢";
      resultMessage = "Oops! Better luck next time!";
      resultColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz Results",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Result Emoji
                Text(
                  resultEmoji,
                  style: TextStyle(fontSize: 80),
                ),
                SizedBox(height: 20),

                // Result Message
                Text(
                  resultMessage,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Score Display
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Your Score",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$score / $totalQuestions",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "(${percentage.toStringAsFixed(1)}%)",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Back to Quizzes Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserQuizListScreen()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Back to Quizzes",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}