import 'package:flutter/material.dart';
import 'Authentication/SignInScreen.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(child:Column(
        children: [
          SizedBox(height: 190),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(role: "admin")));
            },
            child: Card(
              elevation: 20.0,
              shadowColor: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 300,
                color: Colors.orange,
                child: Center(child: Text("Admin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40))),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(role: "user")));
            },
            child: Card(
              elevation: 20.0,
              shadowColor: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 300,
                  color: Colors.orange,
                  child: Center(child: Text("User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40))),
                ),
              ),
            ),
          ),
        ],
      ))
    );
  }
}
