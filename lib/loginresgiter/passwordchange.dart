import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/afterlogin/dropdown.dart';
import 'package:kaamkhoj/homepage.dart';
import 'package:kaamkhoj/test/employer_form.dart';

class PasswordChangePage extends StatefulWidget {
  String type,phoneNo;

  PasswordChangePage(String type,String phoneNo){
    this.type=type;
    this.phoneNo=phoneNo;
    print("Password Change "+type);
  }

  @override
  _PasswordChangePageState createState() => _PasswordChangePageState(type,phoneNo);
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String phoneNo,password,confirm_password;
  final databaseReference = Firestore.instance;

  String type;
  String errorMessage = '';

  _PasswordChangePageState(String type,String phoneNo){
    this.phoneNo=phoneNo;
    this.type=type;
    print(type+phoneNo);
  }


  void UpdateRecord() async {
    await databaseReference.collection(type)
        .document(phoneNo)
        .updateData({
      'password' : password,
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
//      resizeToAvoidBottomInset: ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
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

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Confirm Password'),
                onChanged: (value) {
                  this.confirm_password = value;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
//                verifyPhone();
              if(password==confirm_password){
                errorMessage="";
                UpdateRecord();

              }
              else{
                print("Not Matching");
                setState(() {
                errorMessage = "Password Not Matching";
                });

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
    );
  }
}
