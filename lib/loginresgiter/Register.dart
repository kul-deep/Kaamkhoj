import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kaamkhoj/homepage.dart';
import 'package:kaamkhoj/test/employer_form.dart';

class RegisterPage extends StatefulWidget {
  String type;
  RegisterPage(String type){
    this.type=type;
    print("Register as "+type);
  }

  @override
  _RegisterPageState createState() => _RegisterPageState(type);
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String phoneNo,name,email,password,city;
  final databaseReference = Firestore.instance;

  String smsOTP,type;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  _RegisterPageState(String type){
    this.type=type;
    print("Register as "+type);
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
              createRecord();
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
                      createRecord();
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

  void createRecord() async {
    await databaseReference.collection(type)
        .document(phoneNo)
        .setData({
      'Number': phoneNo,
      'Name' : name,
      'email' : email,
      'password' : password,
      'city' : city,
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
        createRecord();
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
        child: SingleChildScrollView(
                  child: Form(
            key: formKey,
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Full Name'),
                    onChanged: (value) {
                      this.name = value;
                      valid();
                    },
                    validator: (name){
                        Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(name))
                          return 'Invalid username';
                        else
                          return null;

                      },
                       onSaved: (String value){
                           print(value);
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
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email ID'),
                    onChanged: (value) {
                      this.email = value;
                      valid();
                    },
                    validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                      // onSaved: (email)=> _email = email,
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
                ), Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Mobile No.'),
                    onChanged: (value) {
                      this.phoneNo = "+91"+value;
                      valid();

                    },
                    validator: (String value){
                      if(value.length<10){
                        return 'Mobile contains 10 digits';
                      }
                  },
                  onSaved: (String value){
                           print("+91"+value);
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
                ), Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password (minimum 6 characters)'),
                    onChanged: (value) {
                      this.password = value;
                      valid();
                    },
                    validator: (String value){
                      if(value.length<6){
                        return 'Password must contain atleast 6 characters';
                      }
                    
                  },
                  onSaved: (String value){
                           print(value);
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

                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'City'),
                    onChanged: (value) {
                      this.city = value;
                      valid();

                    },
                    validator: (city){
                          Pattern pattern =
                              r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(city))
                            return 'Invalid city name';
                          else
                            return null;

                        },
                     onSaved: (String value){
                           print(value);
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
                RaisedButton(
                  onPressed: () {
                     if (formKey.currentState.validate()){
                          print('yes');
                          // formKey.currentState.();
                    // verifyPhone();
                  }
  },

                  child: Text('Verify'),
                  textColor: Colors.white,
                  elevation: 7,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
 
}
}