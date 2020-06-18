import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/test/thankyouform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kaamkhoj/loginresgiter/data.dart';
import 'package:validators/validators.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class PartnerUsPage extends StatefulWidget {
  @override
  _PartnerUsPageState createState() => _PartnerUsPageState();
}

class _PartnerUsPageState extends State<PartnerUsPage> {
  String phoneNo = "", name = "", email = "", city = "";
  final databaseReference = Firestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorName = '';
  String errorEmail = '';
  String errorMobile = '';
  String errorCity = '';
  String smsOTP, type;
  String verificationId;
  String errorMsg = '';
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;

  bool circularProgress=false;

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String phoneNo1 = prefs.getString('Login');
    await databaseReference
        .collection("data")
        .document(phoneNo1)
        .collection("Partner")
        .document("data")
        .setData({
      'Number': phoneNo,
      'Name': name,
      'email': email,
      'city': city,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThankyouPage(phoneNo)),
    );
  }

  void valid() {
    this._formKey.currentState.save();
    print(city);
    if ((name == "") || (email == "") || (phoneNo == "") || (city == "")) {
      setState(() {
        circularProgress=false;
      });
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
        setState(() {
          circularProgress=false;
        });
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     Future<bool> _onBackPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigatorPage()),
    );
  }
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xfff7e9e9),
          body: SingleChildScrollView(
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 300,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         fit: BoxFit.fill,
                //         image:
                //             AssetImage("assets/images/kaamkhoj_logo.png")),
                //   ),
                // ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Partner Registration Form',
                      style: GoogleFonts.ptSans(
                          color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
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
                            hintText: 'Name of Individual/Agency'),
                        onChanged: (value) {
                          this.name = value.trim();
                          // valid();
                          Pattern pattern =
                              r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(name)) {
                            setState(() {
                              errorName = "Invalid Name";
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
                            hintText: 'Agency Email ID'),
                        onChanged: (value) {
                          this.email = value.trim();
                          // valid();
                          if (EmailValidator.validate(this.email)) {
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
                            hintText: 'Agency Mobile No.'),
                        onChanged: (value) {
                          this.phoneNo = "+91" + value;
                          // valid();
                          if (!isNumeric(value)) {
                            setState(() {
                              errorMobile = "Should Contain Only Digits";
                            });
                          } else {
                            setState(() {
                              errorMobile = "";
                            });

                            if (value.length < 10) {
                              setState(() {
                                errorMobile = "Mobile number contains 10 digits";
                              });
                            }
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
                  child: Form(
                    key: this._formKey,
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: this._typeAheadController,
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
                      ),
                      suggestionsCallback: (pattern) {
                        return CitiesService.getSuggestions(pattern.trim());
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (suggestion) {
                        if(_typeAheadController!=""){
                          errorCity="";
                        }
                        this._typeAheadController.text = suggestion;
                      },
                      onSaved: (value) {
                        this.city = value;
                      },
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
                (circularProgress ?
                Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(0xff, 0x88, 0x02, 0x0b)))),
                ):
                _button()),

              ],
            )),
          ),
        ),
      ),
    );
  }

  _button() {
    return   ButtonTheme(
      height: 40,
      minWidth: 290,
      child: Align(
        alignment: Alignment.center,
        child: RaisedButton(
            onPressed: () {
              check_internet().then((intenet) {
                if (intenet != null && intenet) {
                  setState(() {
                    circularProgress=true;
                  });
                  valid();
                }
                else{
                  Toast.show("No Internet!\nCheck your Connection or Try Again", context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              });

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
    );
  }
}
