import 'package:flutter/material.dart';

class Other extends StatelessWidget {
  const Other({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Entertainment'),
      ),
      body: ListView(
        children: const <Widget>[
          ExpansionTile(
            title: Text('Games'),
            // Contents
            children: [
              ListTile(
                title: Text('Small games'),
                subtitle: Text("Uno\nChess\nBridge"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Music'),
            subtitle: Text('Pack your singers and equipment'),
            children: [
              ListTile(
                title: Text('Music things'),
                subtitle: Text('Guitars \nFlute \nHymn book'),
              ),
      ],
              ),
            ],
          ),
    );
  }
}
