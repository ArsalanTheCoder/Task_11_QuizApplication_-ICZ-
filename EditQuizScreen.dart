import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EditQuizScreen extends StatefulWidget {
  final String quizId;
  final Map<String, dynamic> quizData;

  EditQuizScreen({required this.quizId, required this.quizData});

  @override
  _EditQuizScreenState createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.quizData['title'] ?? '';
    _descriptionController.text = widget.quizData['description'] ?? '';
  }

  void _updateQuiz() {
    FirebaseDatabase.instance.ref("quizzes/${widget.quizId}").update({
      "title": _titleController.text,
      "description": _descriptionController.text,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quiz updated successfully!")),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update quiz.")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Quiz"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Quiz Title"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Quiz Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateQuiz,
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
