import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/fragments/choose_work.dart';
import 'package:kaamkhoj/fragments/payment.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:kaamkhoj/mail_test.dart';
import 'package:kaamkhoj/notifications.dart';
import 'package:kaamkhoj/paytmPayment/PaymentPaytmPage.dart';
import 'package:kaamkhoj/test1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:kaamkhoj/fragments/about_us.dart';

import 'NavigatorPages/navigatorPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('Login');
  print(token);

  runApp(
    MaterialApp(
        theme: new ThemeData(
          primaryColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        ),
//      home: PaytmPaymentPage()),
        home: token == null ? MyApp1("Login") : MyApp1("Navigator")),
  );
}


class MyApp1 extends StatefulWidget {
  String type;

  MyApp1(String type) {
    this.type = type;
  }

  @override
  _MyAppState createState() => new _MyAppState(type);
}

class _MyAppState extends State<MyApp1> {
  String type;
  int _counter;
  Timer _timer;

  _MyAppState(String type) {
    this.type = type;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
//    FocusScope.of(context).requestFocus(new FocusNode());
    _startTimer();
  }

  _startTimer() {
    _counter = 03;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          if (type == "Login") {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NavigatorPage()));
          }
        }
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {});

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("981fc4a2-48e3-4186-b18f-7a52d3ad217f", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigator Page',
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(0xff, 0xf5, 0xea, 0xea),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        child: Text('KaamKhoj',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                fontSize: 40,
                                fontWeight: FontWeight.bold))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 275,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/logo.png")),
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                          child: Text(
                            'Reliable Help Anytime Anywhere',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
//      home: SafeArea(
//              child: Scaffold(
//          body: Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                  fit: BoxFit.fill,
//                  image: AssetImage("assets/images/splashscreen.png")
//              ),
//            ),
//          ),
//        ),
//      ),
      theme: new ThemeData(
        primaryColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      ),
    );
  }
}

