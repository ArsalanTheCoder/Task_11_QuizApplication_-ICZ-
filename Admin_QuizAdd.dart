import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider_Screen.dart';

class AdminQuizadd extends StatefulWidget {
  const AdminQuizadd({super.key});

  @override
  State<AdminQuizadd> createState() => _AdminQuizaddState();
}

class _AdminQuizaddState extends State<AdminQuizadd> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();

  // Reset Question and options fields.
  void resetQuestionField() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
    answerController.clear();
  }

  // Reset the All remaining fields
  void resetFields() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Quiz", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Quiz Title
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Quiz Title",
                      hintText: "Enter the quiz title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.title_outlined, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title Field Cannot be empty!";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      quizProvider.setTitle(value);
                    },
                  ),
                  SizedBox(height: 15),

                  // Quiz Description
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.description_outlined, color: Colors.blue),
                      labelText: "Quiz Description",
                      hintText: "Enter the quiz description",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Description Field Cannot be empty!";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      quizProvider.setDescription(value);
                    },
                  ),
                  SizedBox(height: 15),

                  // Question Text
                  TextFormField(
                    controller: questionController,
                    decoration: InputDecoration(
                      labelText: "Question",
                      hintText: "Enter the Question",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.question_mark_outlined, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Question Field Cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),

                  // Options (4 fields)
                  Row(
                    children: [
                      SizedBox(width: 10),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          controller: option1Controller,
                          decoration: InputDecoration(
                            labelText: "Option 1",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.blue, width: 3),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.keyboard_option_key, color: Colors.blue),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          controller: option2Controller,
                          decoration: InputDecoration(
                            labelText: "Option 2",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.blue, width: 3),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.keyboard_option_key_outlined, color: Colors.blue),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Row(
                    children: [
                      SizedBox(width: 10),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          controller: option3Controller,
                          decoration: InputDecoration(
                            labelText: "Option 3",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.blue, width: 3),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.keyboard_option_key, color: Colors.blue),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          controller: option4Controller,
                          decoration: InputDecoration(
                            labelText: "Option 4",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.blue, width: 3),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.keyboard_option_key_outlined, color: Colors.blue),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Can't be empty!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),

                  // Answer Field
                  TextFormField(
                    controller: answerController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.question_answer_outlined, color: Colors.blue),
                      labelText: "Answer",
                      hintText: "Answer of the above question",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Answer Field Cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  // Add Question Button
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Add question to the provider
                        quizProvider.addQuestion(
                          questionController.text,
                          [
                            option1Controller.text,
                            option2Controller.text,
                            option3Controller.text,
                            option4Controller.text,
                          ],
                          int.parse(answerController.text) - 1, // Convert to 0-based index
                        );
                        resetQuestionField();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Question added!")),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      "Add Question",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 35),

                  // Save Quiz Button
                  ElevatedButton(
                    onPressed: () async {
                        try {
                          // Save the quiz
                          await Provider.of<QuizProvider>(context, listen: false).saveQuiz();
                          resetFields();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Quiz saved successfully!")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${e.toString()}")),
                          );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue[300],
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Save Quiz",
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}