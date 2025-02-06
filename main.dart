import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_11_quiz_app/HomeScreen.dart';
import 'package:task_11_quiz_app/Provider_Screen.dart';
import 'Admin_Panel/Admin_QuizAdd.dart';
import 'User_Panel/UserQuizListScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Succesfully Firebase Initialized!.");
  } catch(e){
    print("Error Occured: !${e.toString()}");
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
