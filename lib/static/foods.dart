import 'package:flutter/material.dart';

class Foods extends StatelessWidget {
  const Foods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foods'),
      ),
      body: ListView(
        children: const <Widget>[
          ExpansionTile(
            title: Text('Indefinite shelf life'),
            // Contents
            children: [
              ListTile(
                title: Text('Rice'),
              ),
              ListTile(
                title: Text('Dried lentils, peas, beans'),
              ),
              ListTile(
                title: Text('Salt'),
              ),
              ListTile(
                title: Text('Sugar'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('3 Year Shelf Life'),
            children: [
              ListTile(
                title: Text('Dried garlic'),

              ),
              ListTile(
                title: Text('Dried Vegetables'),

              ),
            ],
          ),
          ExpansionTile(
            title: Text('2 Year Shelf Life'),
            children: [
              ListTile(
                title: Text('Coconut oil'),
              ),
              ListTile(
                title: Text('Dried herbs'),
              ),
              ListTile(
                title: Text('Condensed milk'),
              ),
              ListTile(
                title: Text('Pasta'),
              ),
              ListTile(
                title: Text('Cooking oil'),
              ),
              ListTile(
                title: Text('Peanuts'),
              ),
              ListTile(
                title: Text('Honey'),
              ),
              ListTile(
                title: Text('Powdered Soups'),
              ),
              ListTile(
                title: Text('Dried meats'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('1 Year Shelf Life'),
            children: [
              ListTile(
                title: Text('Oats'),
                subtitle: Text('1 kg feeds 20 people'),
              ),
              ListTile(
                title: Text('Parmesan Cheese'),
                subtitle: Text('1 cup = 451 calories'),
              ),
              ListTile(
                title: Text('Peanut Butter'),
                subtitle: Text('1 cup = 1580 calories'),
              ),
              ListTile(
                title: Text('Popcorn Kernels'),
                subtitle: Text('1 cup = 350 calories'),
              ),
              ListTile(
                title: Text('Raisins'),
                subtitle: Text('140g = 440 calories'),
              ),
              ListTile(
                title: Text('Powdered Milk'),
              ),
              ListTile(
                title: Text('Corn Meal'),
              ),
              ListTile(
                title: Text('Dehydrated potato mash'),
                subtitle: Text('1cup = 215 calories'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('6 month Shelf Life'),
            children: [
              ListTile(
                title: Text('Brown Flour'),
              ),
              ListTile(
                title: Text('Tomato Paste'),
              ),
              ListTile(
                title: Text('Samp'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
