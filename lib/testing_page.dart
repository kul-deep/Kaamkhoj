import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:carousel_pro/carousel_pro.dart';

class TestingPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 25,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigatorPage()),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[_column()]),
                ))),
      ),
    );
  }

  Widget _column() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: 35)),
              Center(
                child: Icon(
                  Icons.report,
                  size: 100,
                  color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10)),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child:
                    Text('OOPS!', style: font1, textAlign: TextAlign.justify),
              )),
              Center(
                child: Text('Your Transaction has been failed.',
                    style: font2, textAlign: TextAlign.justify),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ButtonTheme(
                      height: 40,
                      minWidth: 90,
                      child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'Retry',
                              style: GoogleFonts.karla(
                                  color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.white,
                            elevation: 7,
                            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: ButtonTheme(
                      height: 40,
                      minWidth: 90,
                      child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'Close',
                              style: GoogleFonts.karla(
                                  color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.white,
                            elevation: 7,
                            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                      ),
                    ),
                  ),
                ],
              ),
            ]));
  }
}
