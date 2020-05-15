// import 'package:flutter/material.dart';
// import 'src/app.dart';
// void main(){
//     runApp(App());
// }
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   final appTitle = 'Kaamkhoj';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appTitle,
//       home: MyHomePage(title: appTitle),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final String title;

//   MyHomePage({Key key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(child: Text('My Page!')),
//       drawer: Drawer(
//         // Add a ListView to the drawer. This ensures the user can scroll
//         // through the options in the drawer if there isn't enough vertical
//         // space to fit everything.
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text('Drawer Header'),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             ListTile(
//               title: Text('Item 1'),
//               onTap: () {
//                 // Update the state of the app
//                 // ...
//                 // Then close the drawer
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: Text('Item 2'),
//               onTap: () {
//                 // Update the state of the app
//                 // ...
//                 // Then close the drawer
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//import 'NavigatorPages/navigatorPage.dart';
//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'NavigationDrawer Demo',
//      theme: new ThemeData(
//        fontFamily:'OpenSans',
//        primarySwatch: Colors.blue,
//        textTheme: GoogleFonts.latoTextTheme(
//        Theme.of(context).textTheme,
//    ),
//        // textTheme: TextTheme(
//
//        //   body1: TextStyle(fontStyle: FontStyle.italic),
//
//        //  )
//      ),
//      home: new NavigatorPage(),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'dart:async';

//import OneSignal
import 'package:onesignal_flutter/onesignal_flutter.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _debugLabelString = "";
  String _emailAddress;
  String _externalUserId;
  bool _enableConsentButton = true;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      this.setState(() {
        _debugLabelString =
        "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
            (OSEmailSubscriptionStateChanges changes) {
          print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
        });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("981fc4a2-48e3-4186-b18f-7a52d3ad217f", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });
  }

  void _handlePromptForPushPermission() {
    print("Prompting for Permission");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  void _handleGetPermissionSubscriptionState() {
    print("Getting permissionSubscriptionState");
    OneSignal.shared.getPermissionSubscriptionState().then((status) {
      this.setState(() {
        _debugLabelString = status.jsonRepresentation();
      });
    });
  }

  void _handleSendNotification() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "this is a test from OneSignal's Flutter SDK",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);

    this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Flutter and OneSignal'),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: new Table(
                children: [
                  new TableRow(children: [
                    new OneSignalButton("Prompt for Push Permission",
                        _handlePromptForPushPermission, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Print Permission Subscription State",
                        _handleGetPermissionSubscriptionState,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Post Notification",
                        _handleSendNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new Container(
                      child: new Text(_debugLabelString),
                      alignment: Alignment.center,
                    )
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}

typedef void OnButtonPressed();

class OneSignalButton extends StatefulWidget {
  final String title;
  final OnButtonPressed onPressed;
  final bool enabled;

  OneSignalButton(this.title, this.onPressed, this.enabled);

  State<StatefulWidget> createState() => new OneSignalButtonState();
}

class OneSignalButtonState extends State<OneSignalButton> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          RaisedButton.icon(
            color: Colors.lightBlue,
            icon: Icon(Icons.notifications),
            textColor: Colors.white,
            label: Text(widget.title),
            onPressed: widget.enabled ? widget.onPressed : null,
          )
        ]),
        TableRow(children: [
          Container(
            height: 8.0,
          )
        ]),
      ],
    );
  }
}




























// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'Register.dart';
// import 'chooselogin.dart';
// import 'homepage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// void main(){
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp( ChooseType("register"),
//   );
// }

// class MyApp1 extends StatelessWidget {
//   final databaseReference = Firestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Phone',
//         home:Scaffold(
//       appBar: AppBar(
//         title: Text('FireStore Demo'),
//       ),
//       body: Center(
//           child: Column(

//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               RaisedButton(
//                 child: Text('Create Record'),
//                 onPressed: () {
//                   createRecord();
//                 },
//               ),
//               RaisedButton(
//                 child: Text('View Record'),
//                 onPressed: () {
//                   getData();
//                 },
//               ),
//               RaisedButton(
//                 child: Text('Update Record'),
//                 onPressed: () {
//                   updateData();
//                 },
//               ),
//               RaisedButton(
//                 child: Text('Delete Record'),
//                 onPressed: () {
//                   print("done");
//                   deleteData();
//                 },
//               ),
//             ],
//           )), //center
//     )
//     );
//   }

//   void createRecord() async {
//     print("done");
//     await databaseReference.collection("employee")
//         .document("Aditya")
//         .setData({
//       'title': 'Mastering Flutter',
//       'description': 'Programming Guide for Dart'
//     });

// //    DocumentReference ref = await databaseReference.collection("books")
// //        .add({
// //      'title': 'Flutter in Action',
// //      'description': 'Complete Programming Guide to learn Flutter'
// //    });
// //    print(ref.documentID);
//   }

//   void getData() {
// //    databaseReference
// //        .collection("books")
// //        .getDocuments()
// //        .then((QuerySnapshot snapshot) {
// //      snapshot.documents.forEach((f) => print('${f.data}}'));
// //    });

//     DocumentReference documentReference =
//     databaseReference.collection("employee").document("Aditya");
//     documentReference.get().then((datasnapshot) {
//       if (datasnapshot.exists) {
//        print(datasnapshot.data.toString());
//       }
//       else {
//         print("No such user");
//       }
//     });

//   }

//   void updateData() {
//     try {
//       databaseReference
//           .collection('books')
//           .document('1')
//           .updateData({'description': 'Head First Flutter'});
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void deleteData() {
//     try {
//       databaseReference
//           .collection('books')
//           .document('Aditya')
//           .delete();
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }


// //void main() => runApp(MyApp());
// //
//   class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Phone Authentication',
//       routes: <String, WidgetBuilder>{
//         '/homepage': (BuildContext context) => HomePage(),
//         '/loginpage': (BuildContext context) => MyApp(),
//       },
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RegisterPage('Phone Authentication'),
//     );
//   }
// }
// //
// //class MyAppPage extends StatefulWidget {
// //  MyAppPage({Key key, this.title}) : super(key: key);
// //  final String title;
// //
// //  @override
// //  _MyAppPageState createState() => _MyAppPageState();
// //}
// //
// //class _MyAppPageState extends State<MyAppPage> {
// //  String phoneNo;
// //  String smsOTP;
// //  String verificationId;
// //  String errorMessage = '';
// //  FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //  Future<void> verifyPhone() async {
// //    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
// //      this.verificationId = verId;
// //      smsOTPDialog(context).then((value) {
// //        print('sign in');
// //      });
// //    };
// //    try {
// //      await _auth.verifyPhoneNumber(
// //          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
// //          codeAutoRetrievalTimeout: (String verId) {
// //            //Starts the phone number verification process for the given phone number.
// //            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
// //            this.verificationId = verId;
// //          },
// //          codeSent:
// //          smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
// //          timeout: const Duration(seconds: 20),
// //          verificationCompleted: (AuthCredential phoneAuthCredential) {
// //            print(phoneAuthCredential);
// //          },
// //          verificationFailed: (AuthException exceptio) {
// //            print('${exceptio.message}');
// //          });
// //    } catch (e) {
// //      handleError(e);
// //    }
// //  }
// //
// //  Future<bool> smsOTPDialog(BuildContext context) {
// //    return showDialog(
// //        context: context,
// //        barrierDismissible: false,
// //        builder: (BuildContext context) {
// //          return new AlertDialog(
// //            title: Text('Enter SMS Code'),
// //            content: Container(
// //              height: 85,
// //              child: Column(children: [
// //                TextField(
// //                  keyboardType: TextInputType.phone,
// //                  onChanged: (value) {
// //                    this.smsOTP = value;
// //                  },
// //                ),
// //                (errorMessage != ''
// //                    ? Text(
// //                  errorMessage,
// //                  style: TextStyle(color: Colors.red),
// //                )
// //                    : Container())
// //              ]),
// //            ),
// //            contentPadding: EdgeInsets.all(10),
// //            actions: <Widget>[
// //              FlatButton(
// //                child: Text('Done'),
// //                onPressed: () {
// //                  _auth.currentUser().then((user) {
// //                    if (user != null) {
// //                      Navigator.of(context).pop();
// //                      Navigator.of(context).pushReplacementNamed('/homepage');
// //                    } else {
// //                      signIn();
// //                    }
// //                  });
// //                },
// //              )
// //            ],
// //          );
// //        });
// //  }
// //
// //  signIn() async {
// //    try {
// //      final AuthCredential credential = PhoneAuthProvider.getCredential(
// //        verificationId: verificationId,
// //        smsCode: smsOTP,
// //      );
// //      final FirebaseUser user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
// //      final FirebaseUser currentUser = await _auth.currentUser();
// //      assert(user.uid == currentUser.uid);
// //      Navigator.of(context).pop();
// //      Navigator.of(context).pushReplacementNamed('/homepage');
// //    } catch (e) {
// //      handleError(e);
// //    }
// //  }
// //
// //  handleError(PlatformException error) {
// //    print(error);
// //    switch (error.code) {
// //      case 'ERROR_INVALID_VERIFICATION_CODE':
// //        FocusScope.of(context).requestFocus(new FocusNode());
// //        setState(() {
// //          errorMessage = 'Invalid Code';
// //        });
// //        Navigator.of(context).pop();
// //        smsOTPDialog(context).then((value) {
// //          print('sign in');
// //        });
// //        break;
// //      default:
// //        setState(() {
// //          errorMessage = error.message;
// //        });
// //
// //        break;
// //    }
// //  }
// //
// //  @override
// //  Widget build(BuildContext context) {
// //    return Scaffold(
// //      appBar: AppBar(
// //        title: Text(widget.title),
// //      ),
// //      body: Center(
// //        child: Column(
// //          mainAxisAlignment: MainAxisAlignment.center,
// //          children: <Widget>[
// //            Padding(
// //              padding: EdgeInsets.all(10),
// //              child: TextField(
// //                keyboardType: TextInputType.phone,
// //                decoration: InputDecoration(
// //                    hintText: 'Enter Phone Number Eg. 0000000000'),
// //                onChanged: (value) {
// //                  this.phoneNo = "+91"+value;
// //                },
// //              ),
// //            ),
// //            (errorMessage != ''
// //                ? Text(
// //              errorMessage,
// //              style: TextStyle(color: Colors.red),
// //            )
// //                : Container()),
// //            SizedBox(
// //              height: 10,
// //            ),
// //            RaisedButton(
// //              onPressed: () {
// //                verifyPhone();
// //                verifyPhone();
// //              },
// //              child: Text('Verify'),
// //              textColor: Colors.white,
// //              elevation: 7,
// //              color: Colors.blue,
// //            )
// //          ],
// //        ),
// //      ),
// //    );
// //  }
// //}
