import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ServicesPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
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
              //  color: Colors.white,
              padding: EdgeInsets.only( top: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text('Services We Provide',style: font2),
                    Container(margin: EdgeInsets.only(bottom:20),),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Table(
//           border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(children: [
                            Text('•   Babysitter', style: font1),
                            Text('•   Cook', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Domestic Helper', style: font1),
                            Text('•   Housemaid', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Home Tutions', style: font1),
                            Text('•   Japa Maid', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Patient Care', style: font1),
                            Text('•   Office Boy', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Carpenter', style: font1),
                            Text('•   Couple', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Delivery Boy', style: font1),
                            Text('•   Driver', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Electrician', style: font1),
                            Text('•   Helper', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   House Boy', style: font1),
                            Text('•   Nanny', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Mason', style: font1),
                            Text('•   Nurse', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Office Assistant', style: font1),
                            Text('•   Painter', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Peon', style: font1),
                            Text('•   Plumber', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Salesman', style: font1),
                            Text('•   Security Guard', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   Computer', style: font1),
                            Text('•   Data Entry', style: font1),
                          ]),
                          TableRow(children: [
                            Text('    Operator', style: font1),
                            Text('    Operator', style: font1),
                          ]),
                          TableRow(children: [
                            Text('•   House Supervisor', style: font1),
                            Text(''),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
