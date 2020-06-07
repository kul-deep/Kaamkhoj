import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ThankyouPage extends StatefulWidget {
  @override
  ThankyouPageState createState() => new ThankyouPageState();
}

class ThankyouPageState extends State<ThankyouPage> {
  int _counter;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _counter = 15;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => NavigatorPage()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(0xff, 0xf5, 0xea, 0xea),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/upper.png")),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Thank You',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
