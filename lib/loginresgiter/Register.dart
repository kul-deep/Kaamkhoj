// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:validators/validators.dart';
import 'data.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

//import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:email_validator/email_validator.dart';

// import 'package:kaamkhoj/homepage.dart';
// import 'package:kaamkhoj/test/employer_form.dart';

class RegisterPage extends StatefulWidget {
  final String lastPin;
  final int fields;
  final ValueChanged<String> onSubmit;
  final num fieldWidth;
  final num fontSize;
  final bool isTextObscure;
  final bool showFieldAsBox;

  RegisterPage(
      {this.lastPin,
      this.fields: 6,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//  final formKey = GlobalKey<FormState>();
  String phoneNo = "",
      name = "",
      email = "",
      password = "",
      city = "",
      otp = "0";
  int resendotp = 0;
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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

  //--------------------------OTP Handle Methods----------------//
  int _counter = 30;
  Color c = Colors.grey[700];
  Timer _timer;

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          resendotp = 1;
          setState(() {
            c = Color.fromARGB(0xff, 0x88, 0x02, 0x0b);
          });
        }
      });
    });
  }

  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context, i == 0);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context, [bool autofocus = false]) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        autofocus: autofocus,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            // color: Colors.black,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            border: widget.showFieldAsBox
                ? OutlineInputBorder(borderSide: BorderSide(width: 2.0))
                : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  //---------------------------------------//

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() {
        otp = "1";
        c = Colors.grey[700];
        _startTimer();
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
      print(e.toString());
    }
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

  signIn(smsotp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsotp,
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
    print("inside" + phoneNo);

    final snapShot =
        await Firestore.instance.collection('data').document(phoneNo).get();

    if (snapShot == null || !snapShot.exists) {
      print("Verify Phone");
      verifyPhone();
    } else {
      setState(() {
        errorMsg = "User Already Exist";
      });
      Toast.show("User Already Exist", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void valid() {
    this._formKey.currentState.save();
    print(city);
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
    return otp == "0"
        ? SafeArea(
            child: Scaffold(
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
                            image:
                                AssetImage("assets/images/kaamkhoj_logo.png")),
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
                      padding: EdgeInsets.only(
                          left: 35, top: 15, right: 35, bottom: 10),
                      child: Center(
                        child: Container(
                          height: 55,
                          child: TextField(
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                    color:
                                        Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                      padding: EdgeInsets.only(
                          left: 35, top: 15, right: 35, bottom: 10),
                      child: Center(
                        child: Container(
                          height: 55,
                          child: TextField(
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                    color:
                                        Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                      padding: EdgeInsets.only(
                          left: 35, top: 15, right: 35, bottom: 10),
                      child: Center(
                        child: Container(
                          height: 55,
                          child: TextField(
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                    color:
                                        Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                              if(!isNumeric(value)){
                                setState(() {
                                  errorMobile = "Should Contain Only Digits";
                                });
                              }
                              else {

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
                      padding: EdgeInsets.only(
                          left: 35, top: 15, right: 35, bottom: 10),
                      child: Center(
                        child: Container(
                          height: 55,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                    color:
                                        Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                      padding: EdgeInsets.only(
                          left: 35, top: 15, right: 35, bottom: 10),
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
                            return CitiesService.getSuggestions(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
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
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xfff7e9e9),
              resizeToAvoidBottomPadding: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                      'Enter OTP',
                      style: GoogleFonts.ptSans(
                          color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  textfields,
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            '00:$_counter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: new GestureDetector(
                            onTap: () {
                              if (resendotp == 1) {
                                resendotp = 0;
                                verifyPhone();
                              }
                            },
                            child: new Text(
                              'Resend OTP',
                              style: GoogleFonts.ptSans(
                                  color: c,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonTheme(
                      height: 40,
                      minWidth: 290,
                      child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                            onPressed: () {
                              var concatenate = StringBuffer();

                              _pin.forEach((item) {
                                concatenate.write(item);
                              });

                              print(concatenate);

                              signIn(concatenate.toString());

                              // sformKey.currentState.();
//                           verifyPhone();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'Verify',
                              style: GoogleFonts.karla(
                                  color:
                                      Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            elevation: 7,
                            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                      )),
                ],
              ),
            ),
          );
  }
}
