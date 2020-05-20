import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';

class PasswordChangePage extends StatefulWidget {
  String phoneNo;

  PasswordChangePage(String phoneNo){
    this.phoneNo=phoneNo;
  }

  @override
  _PasswordChangePageState createState() => _PasswordChangePageState(phoneNo);
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String phoneNo,password,confirm_password;
  final databaseReference = Firestore.instance;

  String errorMessage = '';

  _PasswordChangePageState(String phoneNo){
    this.phoneNo=phoneNo;
  }


  void UpdateRecord() async {
    await databaseReference.collection("data")
        .document(phoneNo)
        .updateData({
      'password' : password,
    });
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
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
