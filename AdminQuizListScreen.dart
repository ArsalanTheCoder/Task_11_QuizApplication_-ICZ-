import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_11_quiz_app/Admin_Panel/Admin_QuizAdd.dart';
import 'EditQuizScreen.dart';

class AdminQuizListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Manage Quizzes"),
        backgroundColor: Colors.blue[800],
        elevation: 4.0,
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("quizzes").onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return Center(child: Text("No quizzes available."));
          } else {
            final dynamic data = snapshot.data!.snapshot.value;
            final Map<String, dynamic> quizzes = convertMap(data);

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                String quizId = quizzes.keys.elementAt(index);
                Map<String, dynamic> quiz = quizzes[quizId] is Map
                    ? quizzes[quizId] as Map<String, dynamic>
                    : {};

                return Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[800],
                      radius: 28,
                      child: Icon(Icons.quiz, color: Colors.white, size: 28),
                    ),
                    title: Text(
                      quiz['title'] ?? "No Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue[900],
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        quiz['description'] ?? "No Description",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit Button
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          tooltip: "Edit Quiz",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditQuizScreen(
                                  quizId: quizId,
                                  quizData: quiz,
                                ),
                              ),
                            );
                          },
                        ),
                        // Delete Button
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          tooltip: "Delete Quiz",
                          onPressed: () => _confirmDelete(context, quizId),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      // Floating Action Button placed outside the list.
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue[800],
          child: Icon(Icons.add, color: Colors.white, size: 30),
          tooltip: "Add New Quiz",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminQuizadd(), // Ensure this screen exists
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  /// Show confirmation dialog before deleting a quiz.
  void _confirmDelete(BuildContext context, String quizId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Delete Quiz",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("Are you sure you want to delete this quiz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              FirebaseDatabase.instance.ref("quizzes/$quizId").remove();
              Navigator.of(ctx).pop();
            },
            child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  /// Convert Firebase data to a valid Map<String, dynamic>
  Map<String, dynamic> convertMap(dynamic data) {
    if (data is Map<Object?, Object?>) {
      return data.map((key, value) {
        final String strKey = key.toString();
        if (value is Map<Object?, Object?>) {
          return MapEntry(strKey, convertMap(value));
        } else if (value is List<Object?>) {
          return MapEntry(strKey, value.map((e) => e).toList());
        } else {
          return MapEntry(strKey, value);
        }
      });
    }
    return {};
  }
}
