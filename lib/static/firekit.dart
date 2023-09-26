import 'package:flutter/material.dart';

class FireKit extends StatelessWidget {
  const FireKit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Fire Kit'),
      ),
      body: ListView(
        children: const <Widget>[
          ExpansionTile(
            title: Text('Firestarters'),
            subtitle: Text('Know how to cook your food and keep warm'),
            // Contents
            children: [
              ListTile(
                title: Text('Ignite your fire'),
                subtitle: Text("Firestarters\nlighters\nMatches"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
