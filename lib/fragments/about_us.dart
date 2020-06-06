// import 'package:flutter/material.dart';

// class SecondFragment extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Center(
//       child: new Text("Hello Fragment 2"),
//     );
//   }

// }
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class AboutUsPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  
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
                  child: Column(children: <Widget>[_column()]),
                ))),
      ),
    );
  }
  // Widget _buildTitle(){
  //   return Container(margin: EdgeInsets.only(top:10),
  //   child: Center(
  //     child: Text('About Us',
  //     style: GoogleFonts.openSans(
  //                     color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
  //                     fontSize: 38,
  //                     fontWeight: FontWeight.bold)),
  //   ),);
  // }

  Widget _column() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Misson', style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Our mission is to provide you with a service experience unmatched by any other organisation.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              Text('Vision', style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Our vision is to be the most competent and innovative organization by making the difference through our people, that consists of a team of dedicated professionals who value their customers, deliver on their promises and contribute to sustainable development.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Our Endeavour', style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Complete solution under one roof.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Creating value for our clients.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Well trained and experienced Customer Care Staff.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Professional approach.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  '• Using technology to create proximity between the Employer\'s and Employee\'s work place.',
                  style: font2,
                  textAlign: TextAlign.justify),
            ]));
  }
}
