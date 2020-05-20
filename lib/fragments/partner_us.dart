import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class PartnerUsPage extends StatefulWidget {
  @override
  _PartnerUsPageState createState() => _PartnerUsPageState();
}

class _PartnerUsPageState extends State<PartnerUsPage> {

  String phoneNo, name = "", email = "", city = "";
  final databaseReference = Firestore.instance;

  String errorName = '';
  String errorEmail = '';
  String errorMobile = '';
  String errorCity = '';
  String smsOTP, type;
  String verificationId;
  String errorMessage = '';


  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String phoneNo1 = prefs.getString('Login');
    await databaseReference.collection("data").document(phoneNo1).collection("Partner").document("data").setData({
      'Number': phoneNo,
      'Name': name,
      'email': email,
      'city': city,
    });  }





  void valid() {
    if ((name == "") || (email == "") || (phoneNo == "") || (city == "")) {
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
          errorCity == "") {
        getStringValuesSF();
        print("Inside");
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
      resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: ,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Partner Registration Form',
                style: GoogleFonts.ptSans(
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, top: 20, right: 35),
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
                          hintText: 'Name of Individual/Agency'),
                      onChanged: (value) {
                        this.name = value;
                        // valid();
                        Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(name)) {
                          setState(() {
                            errorName = "Invalid name";
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, top: 20, right: 35),
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
                          hintText: 'Agency Email ID'),
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, top: 20, right: 35),
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
                          hintText: 'Agency Mobile No.'),
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, top: 20, right: 35),
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
                        Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
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
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                height: 40,
                minWidth: 290,
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: RaisedButton(
                      onPressed: () {
                        valid();
                        // sformKey.currentState.();
                        // verifyPhone();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        'Submit',
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
            ],
          ),
        ),
      ),
    );
  }
}

//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage("assets/images/background.png"),
//              fit: BoxFit.cover)),
//      child: Scaffold(
//        backgroundColor: Colors.transparent,
//        resizeToAvoidBottomPadding: false,
//        resizeToAvoidBottomInset: false,
//        body: Center(
//          child: SingleChildScrollView(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                _buildTitle(),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    decoration: InputDecoration(
//                        // labelText: 'Full Name',
//                        labelText: 'Name of Individual/Agency'),
//                    onChanged: (value) {
//                      this.name = value;
//                    },
//                  ),
//                ),
//                (errorMessage != ''
//                    ? Text(
//                        errorMessage,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextFormField(
//                    keyboardType: TextInputType.phone,
//                    decoration: InputDecoration(
//                        labelText: 'Mobile Number',
//                        hintText: 'Enter 10 digit number'),
//                    onChanged: (value) {
//                      this.phoneNo = "+91" + value;
//                    },
//                  ),
//                ),
//                (errorMessage != ''
//                    ? Text(
//                        errorMessage,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                Padding(
//                  padding: EdgeInsets.all(10),
//                  child: TextField(
//                    decoration: InputDecoration(labelText: 'City'),
//                    onChanged: (value) {
//                      this.city = value;
//                    },
//                  ),
//                ),
//                (errorMessage != ''
//                    ? Text(
//                        errorMessage,
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
//                        labelText: 'Email ID', hintText: 'you@gmail.com'),
//                    onChanged: (value) {
//                      this.email = value;
//                    },
//                  ),
//                ),
//                (errorMessage != ''
//                    ? Text(
//                        errorMessage,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container()),
//                SizedBox(
//                  height: 10,
//                ),
//                RaisedButton(
//                  onPressed: () {
//                    validateRecord();
//                  },
//                  child: Text('Submit'),
//                  textColor: Colors.white,
//                  elevation: 7,
//                  color: Colors.blue,
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
