// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/loginresgiter/data.dart';
import 'package:kaamkhoj/test/thankyouform.dart';
import 'package:toast/toast.dart';
import 'package:email_validator/email_validator.dart';

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
  String radioItemHrs = '';
  String radioItemReligion = '';
  String work, phoneNo;
  String errorGender = '';
  String city = '';
  String email = '';
  String errorCity = '';
  String errorEmail = '';
  String radioItemGender = "";

  bool circularProgress = false;

  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;
  final databaseReference = Firestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        'Hrs': radioItemHrs,
        'Religion': radioItemReligion,
        'Work': work,
        'City': city,
        'Email': email,
        'Gender': radioItemGender,
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
        'Hrs': radioItemHrs,
        'Religion': radioItemReligion,
        'Work': work,
        'City': city,
        'Email': email,
        'Gender': radioItemGender,
      });
    }
    getMail(phoneNo);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThankyouPage(phoneNo),
        ));
  }


  void getMail(String phoneNo1) {
    DocumentReference documentReference =
    databaseReference.collection("data").document(phoneNo1);
    documentReference.get().then((datasnapshot) {
      sendMail(email,datasnapshot.data['Name'].toString());
      sendMailEmployerAdmin(datasnapshot.data['Name'].toString(),datasnapshot.data['Age'].toString(),datasnapshot.data['Gender'].toString(),phoneNo1, datasnapshot.data['city'].toString(),radioItemHrs, radioItemReligion, work, city, email, radioItemGender);
    });
  }

  bool valid() {
    this._formKey.currentState.save();
    if (email == '') {
      setState(() {
        circularProgress = false;
      });
      String errorblank = "Please fill this field";
      if (email == "") {
        setState(() {
          errorEmail = errorblank;
        });
      }
      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorEmail == "") {
        return true;
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
    return false;
  }

  Widget build(BuildContext context) {
    var font1 = GoogleFonts.openSans(
        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.sourceSansPro(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
    return SafeArea(
      child: Scaffold(
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Container(
                              height: 55,
                              child: TextField(
                                decoration: InputDecoration(
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromARGB(
                                            0xff, 0x1d, 0x22, 0x26),
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
                        // (errorEmail != ''
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(left: 85.0),
                        //         child: Text(
                        //           errorEmail,
                        //           style: TextStyle(color: Colors.red),
                        //         ),
                        //       )
                        //     : Container()),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Gender',
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
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: new Text("Male", style: font2)),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemGender,
                                value: 'Female',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemGender = val;
                                  });
                                },
                              ),
                              new Text("Female", style: font2),
                            ],
                          ),
                        ),
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
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
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
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
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
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
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
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("Muslim", style: font2),
                              ),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Any',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Text("Any", style: font2),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 5, top: 20, right: 5, bottom: 20),
                          child: Form(
                            key: this._formKey,
                            child: TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: this._typeAheadController,
                                decoration: InputDecoration(
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromARGB(
                                            0xff, 0x1d, 0x22, 0x26),
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
                                if (_typeAheadController != "") {
                                  errorCity = "";
                                }
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
          )),
    );
  }

  _button() {
    return ButtonTheme(
        height: 40,
        minWidth: 290,
        child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
              onPressed: () {
                if (valid()) {
                  check_internet().then((intenet) {
                    if (intenet != null && intenet) {
                      if (radioItemHrs == '' || radioItemReligion == '') {
                        Toast.show("Please fill all the fields", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      } else {
                        this._formKey.currentState.save();
                        setState(() {
                          circularProgress = true;
                        });
                        if (city != '') {
                          print(radioItemHrs);
                          print(radioItemReligion);
                          createRecord();
                        } else {
                          setState(() {
                            errorCity = "Please fill this field";
                            circularProgress = false;
                          });
                          Toast.show("Please fill all the fields", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        }
                      }
                    } else {
                      Toast.show(
                          "No Internet!\nCheck your Connection or Try Again",
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM);
                    }
                  });
                }
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
