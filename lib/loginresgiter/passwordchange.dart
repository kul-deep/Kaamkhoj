import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:toast/toast.dart';

class PasswordChangePage extends StatefulWidget {
  String phoneNo;

  PasswordChangePage(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  @override
  _PasswordChangePageState createState() => _PasswordChangePageState(phoneNo);
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String phoneNo, password = '', confirm_password = '';
  final databaseReference = Firestore.instance;
  String errorPass = '', errorConPass = '';
  String type;
  String errorMessage = '';

  _PasswordChangePageState(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  void UpdateRecord() async {
    await databaseReference.collection("data").document(phoneNo).updateData({
      'password': password,
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void valid() {
    if ((confirm_password == "") || (password == "")) {
      String errorblank = "Please fill this field";

      if (confirm_password == "") {
        setState(() {
          errorConPass = errorblank;
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
      if (errorConPass == "" && errorPass == "") {
        UpdateRecord();
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff7e9e9),
        resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: ,
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
            Padding(
              padding: EdgeInsets.only(left: 35, top: 20, right: 35, bottom: 5),
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
                        hintText: 'New Password'),
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
            SizedBox(
              height: 10,
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 35, top: 20, right: 35, bottom: 5),
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
                          hintText: 'Confirm New Password'),
                      onChanged: (value) {
                        this.confirm_password = value;
                        if (confirm_password != password) {
                          setState(() {
                            errorConPass = "Passwords are not matching";
                          });
                        } else {
                          setState(() {
                            errorConPass = "";
                          });
                        }
                      },
                    ),
                  ),
                )),
            (errorConPass != ''
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                    child: Text(
                      errorConPass,
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
                        'Submit',
                        style: GoogleFonts.karla(
                            color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
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
