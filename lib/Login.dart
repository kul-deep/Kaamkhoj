import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/homepage.dart';


class LoginPage extends StatefulWidget {

  String type;

  LoginPage(String type){
    this.type=type;
    print("Login as "+type);

  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNo,name,email,password,city;
  final databaseReference = Firestore.instance;

  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;



  void createRecord() async {
    await databaseReference.collection("employee")
        .document(phoneNo)
        .setData({
      'Number': phoneNo,
      'Name' : name,
      'email' : email,
      'password' : password,
      'city' : city,
    });
  }

  void verify() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });

    DocumentReference documentReference =
    databaseReference.collection("employee").document(phoneNo);
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
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
