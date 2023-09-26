import 'package:flutter/material.dart';

class Blackout extends StatelessWidget {
  const Blackout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blackouts'),
      ),
      body: ListView(
        children: const <Widget>[
          ExpansionTile(
            title: Text('Venezuela'),
            subtitle: Text('Blackout on 7 March, 2019'),
            // Contents
            children: [
              ListTile(
                title:
                    Text('Blackout lasted for 5 days for most of the country'),
                subtitle: Text(
                    "Food rotted in the fridges \nPeople had to line up to fetch water \n46 people died \n800 million dollars economic losses"),
              ),
              Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/ven.jpg')),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('South Africa'),
            subtitle: Text('Pending blackout'),
            children: [
              ListTile(
                title: Text(
                    'It has been estimated that it may take between 4 - 6 months to restart the collapsed grid'),
                subtitle: Text('There will be anarchy'),
              ),
              ListTile(
                title: Text('Experts warn ...'),
                subtitle: Text(
                    'There is a high risk of anarchy being triggered in the next 18 months of South Africa as of April 2023'),
              ),
              ListTile(
                title: Text('Infrastructure continues to deteriorate'),
                subtitle: Text(
                    '25 million potholes \n60% sewage and wastewater facilities in critical state \nTheft of pylon metal is causing them to collapse \n2/3 overhead train cables have been stolen'),
              ),
              ListTile(
                title: Text('Crime already an epidemic and getting worse'),
                subtitle: Text(
                    '16 000 kidnapping crimes per year\n30 000 murders/year 82/day\nConsider 8000 people were killed in 12 months in the Ukraine war so R.S.A is practically a war zone'),
              ),
              Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/pothole.jpg')),
              ),
              Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/sewage.jpg')),
              ),
              Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/pylon.jpg')),
              ),
              Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/train.jpg')),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Dangers of loadshedding and blackouts'),
            subtitle: Text('Leads to anarchy'),
            children: [
              ListTile(
                title: Text('Farm production decreases'),
                subtitle: Text(
                    'Unable to irrigate crops \nLoss in production \nSupermarket shelves grow empty'),
              ),
              ListTile(
                title: Text('Farm livestock loss'),
                subtitle: Text('10 million chicks had to be culled because loadshedding caused production backlogs and therfore no space for the chicks'),
              ),
              ListTile(
                title: Text('Businesses start closing down'),
                subtitle: Text(
                    'Paying to keep generators running eats into profits \nEmployees lose their jobs'),
              ),
              ListTile(
                title: Text('Resources on the decline'),
                subtitle: Text(
                    'People start getting desperate and fight amongst themselves for food and water'),
              )
            ],
          ),
          ExpansionTile(
            title: Text('Human limits'),
            subtitle: Text('In extreme conditions...'),
            children: [
              ListTile(
                title: Text('Temperature'),
                subtitle: Text(
                    'No 1 killer is hypothermia - that is when the core body temperature drops 2 degrees. In exteme conditions, humans can live for 3 hours without shelter'),
              ),
              ListTile(
                title: Text('Water'),
                subtitle: Text(
                    'The human body is 60% water. In extreme conditions, humans can live for 3 days without water'),
              ),
              ListTile(
                title: Text('Food'),
                subtitle: Text(
                    'In extreme conditions, a human can live for 3 weeks without food'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
