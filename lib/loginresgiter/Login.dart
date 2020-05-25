import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:kaamkhoj/loginresgiter/forgetpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'Register.dart';
// import 'package:kaamkhoj/homepage.dart';

class LoginPage extends StatefulWidget {
  //  String type;
//  LoginPage(String type) {
//    this.type = type;
//  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//  final formKey = GlobalKey<FormState>();
  String phoneNo = "", password = "";
  String errorMobile = '';
  String errorPass = '';
  String errorMsg = '';

  String type;
  final databaseReference = Firestore.instance;


//  _LoginPageState(String type) {
//    this.type = type;
//    print("Login as " + type);
//  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Login', phoneNo);
    SignIn();
  }

  void valid() {
    if ((phoneNo == "") || (password == "")) {
      String errorblank = "Please fill this field";
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
      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorMobile == "" && errorPass == "") {
        verify();
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  void verify() {
    DocumentReference documentReference =
        databaseReference.collection("data").document(phoneNo);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
//        print(datasnapshot.data['password'].toString());
        if (password == datasnapshot.data['password'].toString()) {
          print("Right Password");
          addStringToSF();
        } else {
          setState(() {
            errorMsg = "Wrong Credentials";
          });
          Toast.show("Wrong Credentials", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          print("Wrong credentials");
        }
      } else {
        setState(() {
          errorMsg = "User does not exist";
        });

        Toast.show("User does not exist", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print("No such user");
      }
    });
  }

  void SignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigatorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff7e9e9),
        resizeToAvoidBottomPadding: false,
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//            Image.asset("assets/images/union.png"),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/kaamkhoj_logo.png")),
                ),
              ),
              Center(
                child: Text(
                  'Login',
                  // style: TextStyle(color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),fontSize: 25,fontFamily: GoogleFonts.robotoTextTheme(),
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
                    // color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                    height: 55,
                    child: TextField(
                      keyboardType: TextInputType.phone,
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
                        prefixIcon: Icon(Icons.phone),

                        // labelText: 'Mobile Number',
                        hintText: 'Mobile Number',
                      ),
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
                      padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
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
                    // color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                    child: TextField(
                      obscureText: true,
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
                          // jfcontentPadding: new EdgeInsets.symmetric(horizontal: 10.0),
                          // labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password'),
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
                      padding: const EdgeInsets.only(left: 85.0),
                      child: Text(
                        errorPass,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container()),
              (errorMsg != ''
                  ? Align(
                alignment: Alignment.center,
                child: Text(
                  errorMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red,fontSize: 13),
                ),
              )
                  : Container()),

              Padding(
                padding: const EdgeInsets.only(top:20),
                child: ButtonTheme(
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
                          'Login',
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
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: GoogleFonts.sourceSansPro(
                          color: Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Forgot Password',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgetPassword()),
                                  )
                                },
                          style: GoogleFonts.sourceSansPro(
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Create an Account? ',
                      style: GoogleFonts.sourceSansPro(
                          color: Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()),
                                  )
                                },
                          style: GoogleFonts.sourceSansPro(
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomPadding: false,
//      body: Center(
//        child: Form(
////          key: formKey,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.all(10),
//                child: TextField(
//                  keyboardType: TextInputType.phone,
//                  decoration: InputDecoration(
//                    hintText: 'Mobile Number',
////                      hintText: 'Enter 10 digit number'
//                  ),
//                  onChanged: (value) {
//                    this.phoneNo = "+91" + value;
//                    // valid();
//                    if (value.length < 10) {
//                      setState(() {
//                        errorMobile = "Mobile number contains 10 digits";
//                      });
//                    } else {
//                      setState(() {
//                        errorMobile = "";
//                      });
//                    }
//                  },
//                ),
//              ),
//              (errorMobile != ''
//                  ? Text(
//                      errorMobile,
//                      style: TextStyle(color: Colors.red),
//                    )
//                  : Container()),
//              SizedBox(
//                height: 10,
//              ),
//              Padding(
//                padding: EdgeInsets.all(10),
//                child: TextFormField(
//                  obscureText: true,
//                  decoration: InputDecoration(
//                      labelText: 'Password', hintText: 'minimum 6 digits'),
//                  onChanged: (value) {
//                    this.password = value;
//                    // valid();
//                    if (value.length < 6) {
//                      setState(() {
//                        errorPass =
//                            "Password must contain atleast 6 characters";
//                      });
//                    } else {
//                      setState(() {
//                        errorPass = "";
//                      });
//                    }
//                  },
//                ),
//              ),
//              (errorPass != ''
//                  ? Text(
//                      errorPass,
//                      style: TextStyle(color: Colors.red),
//                    )
//                  : Container()),
//              SizedBox(
//                height: 10,
//              ),
//              RaisedButton(
//                onPressed: () {
//                  valid();
//                  // verify();
//                },
//                child: Text('Verify'),
//                textColor: Colors.white,
//                elevation: 7,
//                color: Colors.blue,
//              ),
//              new GestureDetector(
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => RegisterPage("employer")),
//                  );
//                },
//                child: new Text("Register"),
//              ),
//              new GestureDetector(
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => ForgetPassword()),
//                  );
//                },
//                child: new Text("Forget Password",
//                  style: GoogleFonts.ptSans(color:Color.fromARGB(0xff, 0x88, 0x02, 0x0b),fontSize:26,fontWeight: FontWeight.bold ),
//                )
//
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
