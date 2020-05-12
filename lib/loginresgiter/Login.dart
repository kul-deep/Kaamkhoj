import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:kaamkhoj/homepage.dart';
import 'package:kaamkhoj/loginresgiter/forgetpassword.dart';


class LoginPage extends StatefulWidget {

  String type;

  LoginPage(String type){
    this.type=type;
  }

  @override
  _LoginPageState createState() => _LoginPageState(type);
}

class _LoginPageState extends State<LoginPage> {
  String phoneNo,password,type;
  final databaseReference = Firestore.instance;

  String errorMessage = '';

  _LoginPageState(String type){
    this.type=type;
    print("Login as "+type);
  }


  void verify() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });

    DocumentReference documentReference =
    databaseReference.collection(type).document(phoneNo);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['password'].toString());
        if(password==datasnapshot.data['password'].toString()){
          print("Right Password");
          SignIn();
        }
        else{
          errorMessage="Wrong Credentials";
          print("Wrong credentials");
        }
      }
      else {
        print("No such user");
      }
    });
  }


  void SignIn(){

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Mobile No.',
                    hintText: '10 Digits'
                ),
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
            ), Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Password (minimum 6 digits)'),
                onChanged: (value) {
                  this.password = value;
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
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(16, 5, 0,5),
              child:
                new GestureDetector(

                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword(type,phoneNo),
                      )
                    );
                  },
                  child: Text("Forget Password",

                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                ),

            ),
            RaisedButton(
              onPressed: () {
                verify();
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
