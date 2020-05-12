import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:kaamkhoj/homepage.dart';
import 'package:kaamkhoj/loginresgiter/passwordchange.dart';
import 'package:kaamkhoj/test/employer_form.dart';

class ForgetPassword extends StatefulWidget {
  String type,phoneNo;
  ForgetPassword(String type,String phoneNo){
    this.type=type;
    this.phoneNo=phoneNo;
    print("Register as "+type);
  }

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState(type,phoneNo);
}

class _ForgetPasswordPageState extends State<ForgetPassword> {
  String phoneNo,name,email,password,city;
  final databaseReference = Firestore.instance;

  String smsOTP,type;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  _ForgetPasswordPageState(String type,String phoneNo){
    this.type=type;
    this.phoneNo=phoneNo;
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
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
          smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);

            _auth.signInWithCredential(phoneAuthCredential).then((AuthResult result){
              if(type=="Employer") {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => PasswordChangePage("Employer",phoneNo)
                ));
              }
              else {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => PasswordChangePage("Employee",phoneNo)
                ));
              }
            }).catchError((e){
              print(e);
            });

          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
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
                (errorMessage != ''
                    ? Text(
                  errorMessage,
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
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      if(type=="Employer") {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => PasswordChangePage("Employer",phoneNo)
                        ));
                      }
                      else {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => PasswordChangePage("Employee",phoneNo)
                        ));
                      }

                    } else {
                      signIn();
                    }
                  });
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
      final FirebaseUser user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();

//      assert(user.uid == currentUser.uid);
      if(user.uid == currentUser.uid) {
        print(type+"Yes");
        if(type=="Employer") {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChooseYourWork("Employer",phoneNo)
          ));
        }
        else {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChooseYourWork("Employee",phoneNo)
          ));
        }
      }
    } catch (e) {
      print("error");
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//
          Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Mobile No.'),
                onChanged: (value) {
                  this.phoneNo = "+91"+value;
                },
              ),
            ),
            (errorMessage != ''
                ? Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            )
                : Container()),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                verifyPhone();
              },
              child: Text('Verify'),
              textColor: Colors.white,
              elevation: 7,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
