import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ResultsScreen.dart';

class QuizAttemptScreen extends StatefulWidget {
  final String quizId;

  QuizAttemptScreen({required this.quizId});

  @override
  _QuizAttemptScreenState createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  List<int?> _selectedAnswers = [];
  int _score = 0;
  List<Map<String, dynamic>> _questionList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final DatabaseEvent event = await FirebaseDatabase.instance
        .ref("quizzes/${widget.quizId}/questions")
        .once();

    if (event.snapshot.value != null) {
      final Map<dynamic, dynamic> questionsMap =
      Map<dynamic, dynamic>.from(event.snapshot.value as Map);

      setState(() {
        _questionList = questionsMap.entries.map((entry) {
          final questionData = Map<String, dynamic>.from(entry.value);
          return {
            'text': questionData['text'] ?? '',
            'options': List<String>.from(questionData['options'] ?? []),
            'correctAnswerIndex': questionData['correctAnswerIndex'] ?? 0,
          };
        }).toList();

        _selectedAnswers = List<int?>.filled(_questionList.length, null);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attempt Quiz",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.blue[200],
        ),
      )
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (_currentPage + 1) / _questionList.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[200]!),
              minHeight: 10,
            ),
            SizedBox(height: 20),

            // Question Display
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _questionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Question Number
                            Text(
                              "Question ${index + 1}/${_questionList.length}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(height: 20),

                            // Question Text
                            Text(
                              _questionList[index]['text'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 30),

                            // Options
                            ...List.generate(
                              _questionList[index]['options'].length,
                                  (optionIndex) {
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: RadioListTile<int>(
                                    title: Text(
                                      _questionList[index]['options'][optionIndex],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    value: optionIndex,
                                    groupValue: _selectedAnswers[index],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedAnswers[index] = value;
                                      });
                                    },
                                    activeColor: Colors.blue[200],
                                  ),
                                );
                              },
                            ),
                            Spacer(),

                            // Navigation Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (index > 0)
                                  ElevatedButton(
                                    onPressed: () {
                                      _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                      setState(() => _currentPage--);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[200],
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "Back",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_selectedAnswers[index] == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Please select an answer."),
                                          backgroundColor: Colors.red[400],
                                        ),
                                      );
                                      return;
                                    }

                                    if (index < _questionList.length - 1) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                      setState(() => _currentPage++);
                                    } else {
                                      _score = 0;
                                      for (int i = 0; i < _questionList.length; i++) {
                                        if (_selectedAnswers[i] ==
                                            _questionList[i]['correctAnswerIndex']) {
                                          _score++;
                                        }
                                      }
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultsScreen(
                                            score: _score,
                                            totalQuestions: _questionList.length,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[200],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    index == _questionList.length - 1
                                        ? "Submit"
                                        : "Next",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}