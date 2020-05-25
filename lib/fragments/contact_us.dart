import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  @override
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
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: Column(
                  children: <Widget>[_buildTitle(), _column(), _buildTitle2()]),
            ),
          )),
    ));
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Text('Contact Info', style: font1),
      ),
    );
  }

  Widget _column() {
    return Container(
        margin: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'Registered Office : 54, Mamta \'A\' wing, A.M. Marg, Prabhadevi, Mumbai- 400 025.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              Text('Telephone: 022-66661314 / 022-66661414.', style: font2),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('WhatsApp : 08879392064',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Email : customercare@kaamkhoj.co.in',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(top: 10)),
              Center(child: Text('Social Media', style: font1)),
            ]));
  }

  Widget _buildTitle2() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16),
              //  alignment: Alignment.topLeft,
              // padding: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage("assets/images/Facebook.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Facebook',style: font2),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:10,left: 16),
              //  alignment: Alignment.topLeft,
              // padding: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage("assets/images/Instagram.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Instagram',style: font2),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:10,left:16),
              //  alignment: Alignment.topLeft,
              // padding: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage("assets/images/Linkedin.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('LinkedIn',style: font2),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:10,left:16),
              //  alignment: Alignment.topLeft,
              // padding: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage("assets/images/Youtube.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Youtube',style: font2),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:10,left:16),
              //  alignment: Alignment.topLeft,
              // padding: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage("assets/images/Twitter.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Twitter',style: font2),
            ),
          ],
        ),
      ],
    );
  }
}
