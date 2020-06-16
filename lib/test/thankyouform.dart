import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ThankyouPage extends StatefulWidget {
  String phoneNo;

  ThankyouPage(String phoneNo){
    this.phoneNo=phoneNo;
  }
  @override
  ThankyouPageState createState() => new ThankyouPageState(phoneNo);
}

class ThankyouPageState extends State<ThankyouPage> {
  int _counter;
  Timer _timer;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final databaseReference = Firestore.instance;


  String phoneNo;

  ThankyouPageState(String phoneNo){
    this.phoneNo=phoneNo;
  }


  @override
  void initState() {
    super.initState();
    _startTimer();
    getMail();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _showNotificationWithoutSound();
  }

  Future onSelectNotification(String payload) async {
    return true;
  }

  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }


  _startTimer() {
    _counter = 8;
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
            padding: const EdgeInsets.only(bottom: 60.0),
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
                      'Thank You, You Will Receive Mail or Call For Further Process',
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

  void getMail() {
    DocumentReference documentReference =
    databaseReference.collection("data").document(phoneNo);
    documentReference.get().then((datasnapshot) {
      sendMail(datasnapshot.data['email'].toString());
    });
  }
}
