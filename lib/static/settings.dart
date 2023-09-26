import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_checklist/static/how.dart';
import 'package:my_checklist/static/terms.dart';
import 'package:my_checklist/static/rate.dart';
import 'package:my_checklist/static/about.dart';
import 'package:my_checklist/static/contact.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<String> mylist = [
    'How to use',
    'About me',
    'Contact',
    'Terms and Conditions',
    'rate'
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          textAlign: TextAlign.center,
          selectionColor: Colors.blue,
          // Selects a mid-range green.
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 100.0,
        backgroundColor: Colors.white,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(w / 38),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Container(
                      margin: EdgeInsets.only(top: w / 20),
                      height: h / 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          mylist[index],
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.12,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),

                          // style: GoogleFonts.laila(
                          //   textStyle:
                          //   Theme
                          //       .of(context)
                          //       .textTheme
                          //       .headlineMedium,
                          //   fontSize: 30,
                          //   fontWeight: FontWeight.w700,
                          //   color: Colors.black54,
                          //
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (index == 0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const How()));
                }
                if (index == 1) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const About()));
                }
                if (index == 2) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Contact()));
                }
                if (index == 3) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Terms()));
                }
                if (index == 4) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Rate()));
                }
              },
              // onTap: ()=>
            );
          },
        ),
      ),
    );
  }
}