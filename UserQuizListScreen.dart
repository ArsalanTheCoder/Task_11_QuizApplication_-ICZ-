import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'QuizAttemptScreen.dart';

class UserQuizListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Quizzes"),
        backgroundColor: Colors.blue[200],
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("quizzes").onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text("No quizzes available."));
          } else {
            // Convert Firebase data to a valid Map<String, dynamic>
            final dynamic data = snapshot.data!.snapshot.value;
            final Map<String, dynamic> quizzes = convertMap(data);

            return ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                String quizId = quizzes.keys.elementAt(index);
                Map<String, dynamic> quiz = quizzes[quizId] is Map
                    ? quizzes[quizId] as Map<String, dynamic>
                    : {}; // Ensure it's a map

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.quiz, color: Colors.blue),
                    title: Text(quiz['title'] ?? "No Title"),
                    subtitle: Text(quiz['description'] ?? "No Description"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizAttemptScreen(quizId: quizId),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  /// **🔹 Fix: Convert Firebase Data Properly**
  Map<String, dynamic> convertMap(dynamic data) {
    if (data is Map<Object?, Object?>) {
      return data.map((key, value) {
        // Convert key to String
        final String strKey = key.toString();

        // Recursively handle maps, lists, or direct values
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
