import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.white10,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(50.0),
          child: const Text(
              'Feed back is welcome.\n'
                  "Contact details coming soon",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: 'roboto',

            ),
          ),
        ),


    );
  }
}
