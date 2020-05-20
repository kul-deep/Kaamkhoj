// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

//import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:email_validator/email_validator.dart';

// import 'package:kaamkhoj/homepage.dart';
// import 'package:kaamkhoj/test/employer_form.dart';

class RegisterPage extends StatefulWidget {
  String type;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//  final formKey = GlobalKey<FormState>();
  String phoneNo = "", name = "", email = "", password = "", city = "";

  final databaseReference = Firestore.instance;
  String errorName = '';
  String errorEmail = '';
  String errorMobile = '';
  String errorPass = '';
  String errorCity = '';
  String errorMsg = '';
  String smsOTP, type;
  String verificationId;
  String errorMessage = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

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
              createRecord();
//              Navigator.pushReplacement(context, MaterialPageRoute(
//                  builder: (context) => NavigatorPage()
//              ));
            }).catchError((e) {
              print(e);
            });
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
//      handleError(e);
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
                  signIn();
//                  _auth.currentUser().then((user) {
//                    if (user != null) {
//                      createRecord();
//
////                      Navigator.push(
////                        context,
////                        MaterialPageRoute(
////                            builder: (context) => NavigatorPage()),
////                      );
//                    } else {
//                      signIn();
//                    }
//                  });
                },
              )
            ],
          );
        });
  }

  void createRecord() async {
    await databaseReference.collection("data").document(phoneNo).setData({
      'Number': phoneNo,
      'Name': name,
      'email': email,
      'password': password,
      'city': city,
    });
    addStringToSF();
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Login', phoneNo);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigatorPage()),
    );
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
      createRecord();
    } catch (e) {
      print("error" + e.toString());
//      handleError(e);
    }
  }

  verify() async {
    print("inside"+phoneNo);

    final snapShot =
        await Firestore.instance.collection('data').document(phoneNo).get();

    if (snapShot == null || !snapShot.exists) {
      print("Verify Phone");
      verifyPhone();
    } else {
      setState(() {
        errorMsg="User Already Exist";
      });
      Toast.show("User Already Exist", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void valid() {
    if ((name == "") ||
        (email == "") ||
        (phoneNo == "") ||
        (password == "") ||
        (city == "")) {
      String errorblank = "Please fill this field";
      if (name == "") {
        setState(() {
          errorName = errorblank;
        });
      }
      if (email == "") {
        setState(() {
          errorEmail = errorblank;
        });
      }
      if (phoneNo == "") {
        setState(() {
          errorMobile = errorblank;
        });
      }
      if (password == "") {
        setState(() {
          errorPass = errorblank;
        });
      }
      if (city == "") {
        setState(() {
          errorCity = errorblank;
        });
      }
      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorName == "" &&
          errorEmail == "" &&
          errorMobile == "" &&
          errorPass == "" &&
          errorCity == "") {
        verify();
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7e9e9),
      body: SingleChildScrollView(
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/union.png")),
              ),
            ),
            Center(
              child: Text(
                'Registration Form',
                style: GoogleFonts.ptSans(
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
              child: Center(
                child: Container(
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                            fontSize: 14),
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
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Full Name'),
                    onChanged: (value) {
                      this.name = value;
                      // valid();
                      Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(name)) {
                        setState(() {
                          errorName = "Invalid Username";
                        });
                      } else {
                        setState(() {
                          errorName = "";
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            (errorName != ''
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                    child: Text(
                      errorName,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
            Padding(
              padding:
                  EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
              child: Center(
                child: Container(
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                            fontSize: 14),
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
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email ID'),
                    onChanged: (value) {
                      this.email = value;
                      // valid();
                      if (EmailValidator.validate(value)) {
                        setState(() {
                          errorEmail = "";
                        });
                      } else {
                        setState(() {
                          errorEmail = "Invalid Email Address";
                        });
                      }
                    },
                    // validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                    // onSaved: (email)=> _email = email,
                  ),
                ),
              ),
            ),
            (errorEmail != ''
                ? Padding(
                    padding: const EdgeInsets.only(left: 85.0),
                    child: Text(
                      errorEmail,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
            Padding(
              padding:
                  EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
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
                      // valid();
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
                    padding: const EdgeInsets.only(left: 85.0),
                    child: Text(
                      errorMobile,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
            Padding(
              padding:
                  EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
              child: Center(
                child: Container(
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                            fontSize: 14),
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
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password (minimum 6 characters)'),
                    onChanged: (value) {
                      this.password = value;
                      // valid();
                      if (value.length < 6) {
                        setState(() {
                          errorPass =
                              "Password must contain atleast 6 characters";
                        });
                      } else {
                        setState(() {
                          errorPass = "";
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            (errorPass != ''
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                    child: Text(
                      errorPass,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
            Padding(
              padding:
                  EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
              child: Center(
                child: Container(
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                            fontSize: 14),
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
                        prefixIcon: Icon(Icons.home),
                        hintText: 'City'),
                    onChanged: (value) {
                      this.city = value;
                      // valid();
                      Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(city)) {
                        setState(() {
                          errorCity = "Invalid city name";
                        });
                      } else {
                        setState(() {
                          errorCity = "";
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            (errorCity != ''
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                    child: Text(
                      errorCity,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container()),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RichText(
                text: TextSpan(
                  text: 'By signing up, you agree with our ',
                  style: GoogleFonts.sourceSansPro(
                      color: Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                      fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms and conditions',
                      style: GoogleFonts.sourceSansPro(
                          color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
                // padding: EdgeInsets.only(left:45,top:20,right: 35),

                ),
            (errorMsg != ''
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      errorMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  )
                : Container()),
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
                      'Register',
                      style: GoogleFonts.karla(
                          color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    elevation: 7,
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20),
              child: RichText(
                text: TextSpan(
                  text: 'Already a user? ',
                  style: GoogleFonts.sourceSansPro(
                      color: Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                      fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              )
                            },
                      style: GoogleFonts.sourceSansPro(
                          color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            )
                // padding: EdgeInsets.only(left:45,top:20,right: 35),
                ),
          ],
        )),
      ),
    );
  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
////      resizeToAvoidBottomInset: ,
//      body: Center(
//        child: SingleChildScrollView(
//          child: Form(
////            key: formKey,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    decoration: InputDecoration(hintText: 'Full Name'),
//                    onChanged: (value) {
//                      this.name = value;
//                      // valid();
//                      Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
//                      RegExp regex = new RegExp(pattern);
//                      if (!regex.hasMatch(name)) {
//                        setState(() {
//                          errorName = "Invalid Name";
//                        });
//                      } else {
//                        setState(() {
//                          errorName = "";
//                        });
//                      }
//                    },
//                    // validator: (name){
//                    //     Pattern pattern =
//                    //         r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
//                    //     RegExp regex = new RegExp(pattern);
//                    //     if (!regex.hasMatch(name))
//                    //       return 'Invalid username';
//                    //     else
//                    //       return null;
//
//                    //   },
//                    //    onSaved: (String value){
//                    //        print(value);
//                    //         },
//                  ),
//                ),
//                (errorName != ''
//                    ? Text(
//                        errorName,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    decoration: InputDecoration(hintText: 'Email ID'),
//                    onChanged: (value) {
//                      this.email = value;
//                      // valid();
//                      if (EmailValidator.validate(value)) {
//                        setState(() {
//                          errorEmail = "";
//                        });
//                      } else {
//                        setState(() {
//                          errorEmail = "Invalid Email Address";
//                        });
//                      }
//                    },
//                    // validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
//                    // onSaved: (email)=> _email = email,
//                  ),
//                ),
//                (errorEmail != ''
//                    ? Text(
//                        errorEmail,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    maxLength: 10,
//                    keyboardType: TextInputType.phone,
//                    decoration: InputDecoration(hintText: 'Mobile No.'),
//                    onChanged: (value) {
//                      this.phoneNo = "+91" + value;
//                      // valid();
//                      if (value.length < 10) {
//                        setState(() {
//                          errorMobile = "Mobile number contains 10 digits";
//                        });
//                      } else {
//                        setState(() {
//                          errorMobile = "";
//                        });
//                      }
//                    },
//                    //   validator: (String value){
//                    //     if(value.length<10){
//                    //       return 'Mobile contains 10 digits';
//                    //     }
//                    // },
//                    // onSaved: (String value){
//                    //          print("+91"+value);
//                    //       },
//                  ),
//                ),
//                (errorMobile != ''
//                    ? Text(
//                        errorMobile,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    decoration: InputDecoration(
//                        hintText: 'Password (minimum 6 characters)'),
//                    onChanged: (value) {
//                      this.password = value;
//                      // valid();
//                      if (value.length < 6) {
//                        setState(() {
//                          errorPass =
//                              "Password must contain atleast 6 characters";
//                        });
//                      } else {
//                        setState(() {
//                          errorPass = "";
//                        });
//                      }
//                    },
//                  ),
//                ),
//                (errorPass != ''
//                    ? Text(
//                        errorPass,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    decoration: InputDecoration(hintText: 'City'),
//                    onChanged: (value) {
//                      this.city = value;
//                      // valid();
//                      Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
//                      RegExp regex = new RegExp(pattern);
//                      if (!regex.hasMatch(city)) {
//                        setState(() {
//                          errorCity = "Invalid city name";
//                        });
//                      } else {
//                        setState(() {
//                          errorCity = "";
//                        });
//                      }
//                    },
//                  ),
//                ),
//                (errorCity != ''
//                    ? Text(
//                        errorCity,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                RaisedButton(
//                  onPressed: () {
//                    valid();
//                    // sformKey.currentState.();
//                  },
//                  child: Text('Verify'),
//                  textColor: Colors.white,
//                  elevation: 7,
//                  color: Colors.blue,
//                ),
//                new GestureDetector(
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => LoginPage()),
//                    );
//                  },
//                  child: new Text("Login"),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
}
