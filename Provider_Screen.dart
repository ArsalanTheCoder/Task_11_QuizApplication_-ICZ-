import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

class QuizProvider with ChangeNotifier {
  String _title = '';
  String _description = '';
  List<String> _questions = []; // List of question texts
  List<List<String>> _options = []; // List of options (each question has 4 options)
  List<int> _correctAnswers = []; // List of correct answer indices

  // Getters
  String get title => _title;
  String get description => _description;
  List<String> get questions => _questions;
  List<List<String>> get options => _options;
  List<int> get correctAnswers => _correctAnswers;

  // Setters
  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  // Add a question with its options and correct answer
  void addQuestion(String question, List<String> options, int correctAnswerIndex) {
    _questions.add(question);
    _options.add(options);
    _correctAnswers.add(correctAnswerIndex);
    notifyListeners();
  }

  // Clear all data (optional)
  void clearQuiz() {
    _title = '';
    _description = '';
    _questions.clear();
    _options.clear();
    _correctAnswers.clear();
    notifyListeners();
  }



  Future<void> saveQuiz() async {
  if (_title.isEmpty || _description.isEmpty || _questions.isEmpty) {
  throw Exception("Quiz data is incomplete!");
  }

  // Save quiz to Firebase
  DatabaseReference quizzesRef = FirebaseDatabase.instance.ref("quizzes");
  DatabaseReference newQuizRef = quizzesRef.push(); // Generate a unique quiz ID
  String quizId = newQuizRef.key!;

  // Save quiz metadata (title and description)
  await newQuizRef.set({
  'title': _title,
  'description': _description,
  });

  // Save questions
  DatabaseReference questionsRef = newQuizRef.child("questions");
  for (int i = 0; i < _questions.length; i++) {
  await questionsRef.push().set({
  'text': _questions[i],
  'options': _options[i],
  'correctAnswerIndex': _correctAnswers[i],
  });
  }

  // Clear data after saving (optional)
  clearQuiz();
  }
  }

