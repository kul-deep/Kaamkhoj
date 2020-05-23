import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ThankyouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: Container(
        child: ButtonTheme(
            height: 40,
            minWidth: 290,
            child: Align(
              alignment: Alignment.center,
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatorPage(),
                        ));
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
      )
    );
  }

}