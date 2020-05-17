import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'Register.dart';
// import 'package:kaamkhoj/homepage.dart';

class LoginPage extends StatefulWidget {
  String type;

  LoginPage(String type) {
    this.type = type;
  }

  @override
  _LoginPageState createState() => _LoginPageState(type);
}

class _LoginPageState extends State<LoginPage> {
//  final formKey = GlobalKey<FormState>();
  String phoneNo = "", password = "";
  String errorMobile = '';
  String errorPass = '';
  String type;
  final databaseReference = Firestore.instance;

  String errorMessage = '';

  _LoginPageState(String type) {
    this.type = type;
    print("Login as " + type);
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Login', "Yes");
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
        addStringToSF();
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  void verify() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });

    DocumentReference documentReference =
        databaseReference.collection("data").document(phoneNo);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['password'].toString());
        if (password == datasnapshot.data['password'].toString()) {
          print("Right Password");
          SignIn();
        } else {
          errorMessage = "Wrong Credentials";
          print("Wrong credentials");
        }
      } else {
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Form(
//          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Mobile Number',
//                      hintText: 'Enter 10 digit number'
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
              (errorMobile != ''
                  ? Text(
                      errorMobile,
                      style: TextStyle(color: Colors.red),
                    )
                  : Container()),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password', hintText: 'minimum 6 digits'),
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
              (errorPass != ''
                  ? Text(
                      errorPass,
                      style: TextStyle(color: Colors.red),
                    )
                  : Container()),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  valid();
                  // verify();
                },
                child: Text('Verify'),
                textColor: Colors.white,
                elevation: 7,
                color: Colors.blue,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage("employer")),
                  );
                },
                child: new Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
