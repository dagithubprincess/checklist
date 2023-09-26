import 'package:flutter/material.dart';

class Tools extends StatelessWidget {
  const Tools({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Tools'),
      ),
      body: ListView(
        children: const <Widget>[
          ExpansionTile(
            title: Text('Tool kit'),
            // Contents
            children: [
              ListTile(
                title: Text('Handiwork'),
                subtitle: Text("Duct tape\nScissors\n15m rope\nSewing or crochet kit"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Skillset'),
            subtitle: Text('Make sure you and your family know how to apply survival skills'),
            children: [
              ListTile(
                title: Text('Books'),
                subtitle: Text('Medicinal \nCultural \nMaintenance \nLocal Flora and fauna \nPlanting and Pest control \nSewing or crochet \nCarpentary'),
              ),
              ListTile(
                title: Text('Activities to practise'),
                subtitle: Text('How to make a fire \nHow to set a tent \nHow to hunt \nHow to store meats \nHow to repair clothes \nHow to distill water'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
