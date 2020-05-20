import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class PartnerUsPage extends StatefulWidget {
  @override
  _PartnerUsPageState createState() => _PartnerUsPageState();
}

class _PartnerUsPageState extends State<PartnerUsPage> {
  String phoneNo, name, email, city;
  final databaseReference = Firestore.instance;

  String errorMessage = '';

  void createRecord() async {
    final databaseReference = Firestore.instance;

    await databaseReference.collection("Partner").document(phoneNo).setData({
      'Number': phoneNo,
      'Name': name,
      'email': email,
      'city': city,
    });
  }

  void validateRecord() {
    createRecord();
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Text('Partner Registration Form',
            style: TextStyle(color: Colors.red, fontSize: 25)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        // labelText: 'Full Name',
                        labelText: 'Name of Individual/Agency'),
                    onChanged: (value) {
                      this.name = value;
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
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: 'Enter 10 digit number'),
                    onChanged: (value) {
                      this.phoneNo = "+91" + value;
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
                    decoration: InputDecoration(labelText: 'City'),
                    onChanged: (value) {
                      this.city = value;
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
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email ID', hintText: 'you@gmail.com'),
                    onChanged: (value) {
                      this.email = value;
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
                    validateRecord();
                  },
                  child: Text('Submit'),
                  textColor: Colors.white,
                  elevation: 7,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
