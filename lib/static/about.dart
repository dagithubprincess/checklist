import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About me'),
        backgroundColor: Colors.white10
      ),
      backgroundColor: Colors.blueGrey,
      body:Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(50.0),
            //color: Colors.lightBlueAccent,
            child: const Text("I really love checklists when I'm organising my things.\n "
                "I built this app for like-minded people. \n"
            "This is my first app built using flutter",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),)

          ),
     
    );
  }

}
