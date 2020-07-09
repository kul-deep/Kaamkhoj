// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/test/thankyouform.dart';
import 'package:toast/toast.dart';

class EmployeeForm extends StatelessWidget {
  String work;
  String phoneNo;

  EmployeeForm(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Radiobutton(work, phoneNo),
    ));
  }
}

class Radiobutton extends StatefulWidget {
  String work, phoneNo;

  Radiobutton(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
  }

  @override
  RadioButtonWidget createState() => RadioButtonWidget(work, phoneNo);
}

class RadioButtonWidget extends State {
  String radioItemHrs = '';
  String radioItemReligion = '';
  String work, phoneNo;

  bool circularProgress = false;

  RadioButtonWidget(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
  }

  void createRecord() async {
    final databaseReference = Firestore.instance;

    await databaseReference
        .collection("data")
        .document(phoneNo)
        .collection("Employee")
        .document("data")
        .setData({
      'Hrs': radioItemHrs,
      'Religion': radioItemReligion,
      'Work': work,
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThankyouPage(phoneNo),
        ));
  }

  Widget build(BuildContext context) {
    var font1 = GoogleFonts.openSans(
        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.sourceSansPro(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
    return Scaffold(
        backgroundColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 60, bottom: 60, right: 23, left: 23),
              child: Container(
                padding:
                    EdgeInsets.only(top: 40, bottom: 20, right: 10, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Select Hours',
                          style: font1,
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: new Row(
                          children: <Widget>[
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemHrs,
                              value: '4 Hours',
                              onChanged: (val) {
                                setState(() {
                                  radioItemHrs = val;
                                });
                              },
                            ),
                            new Container(
                              margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 100),
                              child: new Text("4 Hours", style: font2),
                            ),
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemHrs,
                              value: '8 Hours',
                              onChanged: (val) {
                                setState(() {
                                  radioItemHrs = val;
                                });
                              },
                            ),
                            new Text("8 Hours", style: font2),
                          ],
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: new Row(
                          children: <Widget>[
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemHrs,
                              value: '12 Hours',
                              onChanged: (val) {
                                setState(() {
                                  radioItemHrs = val;
                                });
                              },
                            ),
                            new Container(
                              margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 100),
                              child: new Text("12 Hours", style: font2),
                            ),
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemHrs,
                              value: '24 Hours',
                              onChanged: (val) {
                                setState(() {
                                  radioItemHrs = val;
                                });
                              },
                            ),
                            new Text("24 Hours", style: font2),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Select Religion',
                          style: font1,
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: new Row(
                          children: <Widget>[
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemReligion,
                              value: 'Hindu',
                              onChanged: (val) {
                                setState(() {
                                  radioItemReligion = val;
                                });
                              },
                            ),
                            new Container(
                              margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 100),
                              child: new Text("Hindu", style: font2),
                            ),
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemReligion,
                              value: 'Christian',
                              onChanged: (val) {
                                setState(() {
                                  radioItemReligion = val;
                                });
                              },
                            ),
                            new Text("Christian", style: font2),
                          ],
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: new Row(
                          children: <Widget>[
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemReligion,
                              value: 'Muslim',
                              onChanged: (val) {
                                setState(() {
                                  radioItemReligion = val;
                                });
                              },
                            ),
                            new Container(
                              margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 100),
                              child: new Text("Muslim", style: font2),
                            ),
//                        new Radio(
//                              activeColor:Color.fromARGB(0xff, 0x88, 0x02, 0x0b) ,
//                          groupValue: radioItemReligion,
//                          value: 'All',
//                          onChanged: (val) {
//                            setState(() {
//                              radioItemReligion = val;
//                            });
//                          },
//                        ),
//                        new Text("All"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (circularProgress
                          ? Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(
                                                  0xff, 0x88, 0x02, 0x0b)))),
                            )
                          : _button()),
                    ]),
              ),
            ),
          ),
        ));
  }

  _button() {
    return ButtonTheme(
        height: 40,
        minWidth: 290,
        child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
              onPressed: () {
                check_internet().then((intenet) {
                  if (intenet != null && intenet) {
                    if (radioItemHrs == '' || radioItemReligion == '') {
                      Toast.show("Please fill all the fields", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    } else {
                      print(radioItemHrs);
                      print(radioItemReligion);
                      createRecord();
                      setState(() {
                        circularProgress = true;
                      });
                    }
                  } else {
                    Toast.show(
                        "No Internet!\nCheck your Connection or Try Again",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
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
              elevation: 7,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
        ));
  }
}
