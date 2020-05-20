import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:kaamkhoj/loginresgiter/passwordchange.dart';
import 'package:kaamkhoj/test/employer_form.dart';
import 'package:toast/toast.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPassword> {
  String phoneNo = '', name, email, password, city;
  final databaseReference = Firestore.instance;

  String smsOTP, type;
  String verificationId;
  String errorMobile = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  void valid() {
    if ((phoneNo == "")) {
      String errorblank = "Please fill this field";
      if (phoneNo == "") {
        setState(() {
          errorMobile = errorblank;
        });
      }

      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorMobile == "") {
        verifyPhone();
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 30),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);

            _auth
                .signInWithCredential(phoneAuthCredential)
                .then((AuthResult result) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordChangePage(phoneNo)));
            }).catchError((e) {
              print(e);
            });
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMobile != ''
                    ? Text(
                        errorMobile,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  signIn();
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );

      print("inside");
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();

      assert(user.uid == currentUser.uid);
      print("Yes");

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PasswordChangePage(phoneNo)));
    } catch (e) {
      print("error" + e.toString());
//      handleError(e);
    }
  }

//  handleError(PlatformException error) {
//    print(error);
//    switch (error.code) {
//      case 'ERROR_INVALID_VERIFICATION_CODE':
//        FocusScope.of(context).requestFocus(new FocusNode());
//        setState(() {
//          errorMessage = 'Invalid Code';
//        });
//        Navigator.of(context).pop();
//        smsOTPDialog(context).then((value) {
//          print('sign in');
//        });
//        break;
//      default:
//        setState(() {
//          errorMessage = error.message;
//        });
//
//        break;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7e9e9),
      resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: ,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//
            Padding(
              padding: EdgeInsets.only(left: 35, top: 20, right: 35, bottom: 5),
              child: Center(
                child: Container(
                  height: 55,
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                            fontSize: 14),
                        counterText: "",
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Mobile No.'),
                    onChanged: (value) {
                      this.phoneNo = "+91" + value;
                      if (value.length < 10) {
                        setState(() {
                          errorMobile = "Mobile number contains 10 digits";
                        });
                      } else {
                        setState(() {
                          errorMobile = "";
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            (errorMobile != ''
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                    child: Text(
                      errorMobile,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
            SizedBox(
              height: 25,
            ),
            ButtonTheme(
              height: 40,
              minWidth: 290,
              child: Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    onPressed: () {
                      valid();
                      // sformKey.currentState.();
                      // verifyPhone();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'Verify',
                      style: GoogleFonts.karla(
                          color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    elevation: 7,
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
              ),
            )
          ],
        ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomPadding: false,
////      resizeToAvoidBottomInset: ,
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
////
//          Padding(
//              padding: EdgeInsets.all(10),
//              child: TextField(
//                keyboardType: TextInputType.phone,
//                decoration: InputDecoration(
//                    hintText: 'Mobile No.'),
//                onChanged: (value) {
//                  this.phoneNo = "+91"+value;
//                },
//              ),
//            ),
//            (errorMobile != ''
//                ? Text(
//              errorMobile,
//              style: TextStyle(color: Colors.red),
//            )
//                : Container()),
//            SizedBox(
//              height: 10,
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            RaisedButton(
//              onPressed: () {
////                verifyPhone();
//              valid();
//              },
//              child: Text('Verify'),
//              textColor: Colors.white,
//              elevation: 7,
//              color: Colors.blue,
//            )
//          ],
//        ),
//      ),
//    );
//  }
}
