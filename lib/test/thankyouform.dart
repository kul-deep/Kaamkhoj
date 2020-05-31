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
    _counter = 5;
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/thankyou.png")),
          ),
        ),
      ),
    );
  }
}

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Center(
//        child: Container(
//      child: ButtonTheme(
//          height: 40,
//          minWidth: 290,
//          child: Align(
//            alignment: Alignment.center,
//            child: RaisedButton(
//                onPressed: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => NavigatorPage(),
//                      ));
//                },
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(50)),
//                child: Text(
//                  'Submit',
//                  style: GoogleFonts.karla(
//                      color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
//                      fontSize: 16,
//                      fontWeight: FontWeight.bold),
//                ),
//                elevation: 7,
//                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
//          )),
//    ));
//  }
