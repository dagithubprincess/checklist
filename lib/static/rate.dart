import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  const Rate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text('Rate now'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(50.0),
          child: const Text("link coming soon",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontFamily: 'roboto',
          ),),
        ),

    );
  }
}
