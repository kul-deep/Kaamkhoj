// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:toast/toast.dart';

class EmployerForm extends StatelessWidget {
  String work;
  String phoneNo;

  EmployerForm(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
    print("Employer Form" + phoneNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:
//        Container(
//          margin: EdgeInsets.all(16),
          SafeArea(
        child: Radiobutton(work, phoneNo),
      ),
    );
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
  String radioItemGender = '';
  String radioItemHrs = '';
  String radioItemReligion = '';
  String radioItemAge = '';

  String work, phoneNo;
  String city = '';
  String errorCity = '';

  RadioButtonWidget(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
    print(phoneNo);
  }

  void createRecord() async {
    final databaseReference = Firestore.instance;

    final snapShot = await Firestore.instance
        .collection("data")
        .document(phoneNo)
        .collection("Employer")
        .document("0")
        .get();

    if (snapShot == null || !snapShot.exists) {
      print("Collection Not exisit");

      await databaseReference
          .collection("data")
          .document(phoneNo)
          .collection("Employer")
          .document("0")
          .setData({
        'Gender': radioItemGender,
        'Hrs': radioItemHrs,
        'Religion': radioItemReligion,
        'Age': radioItemAge,
        'Work': work,
        'City': city,
      });
    } else {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection("data")
          .document(phoneNo)
          .collection("Employer")
          .getDocuments();
      var list = querySnapshot.documents;
      print(list.length);

      await databaseReference
          .collection("data")
          .document(phoneNo)
          .collection("Employer")
          .document(list.length.toString())
          .setData({
        'Gender': radioItemGender,
        'Hrs': radioItemHrs,
        'Religion': radioItemReligion,
        'Age': radioItemAge,
        'Work': work,
        'City': city,
      });
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigatorPage(),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        child: Padding(
          padding: EdgeInsets.only(top: 60, bottom: 60, right: 23, left: 23),
          child: Container(
            padding: EdgeInsets.only(top: 40, bottom: 20, right: 10, left: 10),
            height: MediaQuery.of(context).size.height - 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Gender',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    new Radio(
                      groupValue: radioItemGender,
                      value: 'Male',
                      onChanged: (val) {
                        setState(() {
                          radioItemGender = val;
                        });
                      },
                    ),
                    new Container(
                      margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                      child: new Text("Male"),
                    ),
                    new Radio(
                      groupValue: radioItemGender,
                      value: 'Female',
                      onChanged: (val) {
                        setState(() {
                          radioItemGender = val;
                        });
                      },
                    ),
                    new Text("Female"),
                  ],
                ),
              ),
              Text(
                'Select Hours',
                style: TextStyle(fontSize: 20),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    new Radio(
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                      child: new Text("4 Hours"),
                    ),
                    new Radio(
                      groupValue: radioItemHrs,
                      value: '8 Hours',
                      onChanged: (val) {
                        setState(() {
                          radioItemHrs = val;
                        });
                      },
                    ),
                    new Text("8 Hours"),
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    new Radio(
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                      child: new Text("12 Hours"),
                    ),
                    new Radio(
                      groupValue: radioItemHrs,
                      value: '24 Hours',
                      onChanged: (val) {
                        setState(() {
                          radioItemHrs = val;
                        });
                      },
                    ),
                    new Text("24 Hours"),
                  ],
                ),
              ),
              Text(
                'Select Religion',
                style: TextStyle(fontSize: 20),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    new Radio(
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                      child: new Text("Hindu"),
                    ),
                    new Radio(
                      groupValue: radioItemReligion,
                      value: 'Christian',
                      onChanged: (val) {
                        setState(() {
                          radioItemReligion = val;
                        });
                      },
                    ),
                    new Text("Christian"),
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    new Radio(
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                      child: new Text("Muslim"),
                    ),
                    new Radio(
                      groupValue: radioItemReligion,
                      value: 'All',
                      onChanged: (val) {
                        setState(() {
                          radioItemReligion = val;
                        });
                      },
                    ),
                    new Text("All"),
                  ],
                ),
              ),
              Text(
                'Employee Age',
                style: TextStyle(fontSize: 20),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Row(
                  children: <Widget>[
                    new Radio(
                      groupValue: radioItemAge,
                      value: '18-30',
                      onChanged: (val) {
                        setState(() {
                          radioItemAge = val;
                        });
                      },
                    ),
                    new Container(
                      margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                      child: new Text("18-30"),
                    ),
                    new Radio(
                      groupValue: radioItemAge,
                      value: '31-40',
                      onChanged: (val) {
                        setState(() {
                          radioItemAge = val;
                        });
                      },
                    ),
                    new Text("31-40"),
                  ],
                ),
              ),
                  new Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          groupValue: radioItemAge,
                          value: '40 & above',
                          onChanged: (val) {
                            setState(() {
                              radioItemAge = val;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                          child: new Text("40 & above"),
                        ),

                         new Radio(
                           groupValue: radioItemAge,
                           value: 'All',
                           onChanged: (val) {
                             setState(() {
                               radioItemAge = val;
                             });
                           },
                         ),
                         new Text("All"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 5, top: 20, right: 5, bottom: 20),
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
                              prefixIcon: Icon(Icons.home),
                              hintText: 'City'),
                          onChanged: (value) {
                            this.city = value;
                            // valid();
                            Pattern pattern =
                                r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(city)) {
                              setState(() {
                                errorCity = "Invalid city name";
                              });
                            } else {
                              setState(() {
                                errorCity = "";
                              });
                            }
                          },
                        ),
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
                          print(city);
                          if (city!=''){
                          print(radioItemGender);
                          print(radioItemHrs);
                          print(radioItemReligion);
                          print(radioItemAge);
                          createRecord();}
                          else{
                            setState(() {
                              errorCity="Please fill this field";
                            });
                            Toast.show("Please fill all the fields", context,
                                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          }
                          //  valid();
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
            ]),
          ),
        ),
      ),
    ));
  }
}
