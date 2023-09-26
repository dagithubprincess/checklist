import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_checklist/screen/my_custom_ui.dart';
import 'package:my_checklist/static/blackout.dart';
import 'package:my_checklist/static/firekit.dart';
import 'package:my_checklist/static/foods.dart';
import 'package:my_checklist/static/other.dart';

import 'package:my_checklist/static/tools.dart';


// media widget measurements rather than the fixed measurements
// add stream builder to remove it from the screen
// Dismissal widget is masked by the ReorderableDragStartListener
// long tap for header
// Double tap to change to done
// Reorderable
// cards
// Delete non-needed items to deleted list. Move them back again
// Back button to the setting page
// Add info links to rung. Not all will have this feature
// Get middle card cenntred
// this will take me to info page of item aka pg 2 expandables. Not all rungs have info. Separate list info for rung info?
// this will take me to info page of item Needs to be index specific// I had to wrap ReorderableDragStartListener with NotificationListner widget to make list scrollable
// Make rung bold and bigger
// Add info tile address infoPage - allowed to be null
// Move data to another page
// text length requiremets in card different for browser and mobile screen
//  screen list is not showing automatically

//Fix task pop up err: fill in submit to db
// Long press be able to make bold, edit and delete - another pop up
// TODO DB in memory of the phone?
// TODO Fix main page and split it
// TODO  Launch on both apple and play store
// TODO Google fonts and staggered animations only used in settings???
//TODO Video explaining how to use the app
//TODO Memory and safety storage/collect more gym images/bubble test mobile/appium and firebase testing dif size device
// TODO add unit/integration testing
// TODO Appium for this app [dayz]
//TODO Settings need data [30]
//TODO Add more data to my list - start researching varous survivial sites and pdf's [15]
//TODO support@prepper.com How to get private email
//TODO need a color pallete as it needs to look better.
// TODO How do I update this when on Appstore [dayz]
// TODO How to Add to appstore [dayz]
//TODO Get db to work on here. Done tutorial. Onhold for this project.
//TODO Store in preferance memory on phone for internationalization? [60] Onhold for this project.
// TODO Add share function [120]. Onhold for now.
// TODO Note all my problems I had with this project
// TODO MVC - model view controller set up stopwatch corona
//TODO limit text length especially for the phone
//TODO Android Studio short cut keys
// TODO Download xcode
//TODO FloatingActionButton Add my realistic data to a table. Maybe do weather app to brush up on table sql stuff first. [120]
//TODO Maximum mobile length for rung text [10] Chrome -66 char Phone - 17 char
//TODO Code widget tree tidy up [30]
// TODO How can people view on Chrome? Get link or still go via app upload route etc. [10]
// TODO Add my cartoon strip later stage? Should be quick drawings maybe via fresco?
// TODO Buy me a coffee feature later on?
//TODO is there a limit to how many objects you can add to this list
//TODO any costs involved in  this app - server etc.
// TODO Legal stuff https://appdevelopermagazine.com/a-guide-for-protecting-your-app-with-a-patent,-trademark,-or-copyright/
// TODO Notifications to tell users there is an update

void main() {
  runApp(const MyApp());
  dev.log("entry", name: "After runapp");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The travel look",
      home: const MyCustomUI(),
      routes: {
        "/blackout": (ctx) => const Blackout(),
        "/foods": (ctx) => const Foods(),
        "/tools": (ctx) => const Tools(),
        "/other": (ctx) => const Other(),
        "/firekit": (ctx) => const FireKit(),
      },
    );
  }
}


