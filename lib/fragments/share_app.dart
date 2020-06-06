import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ShareAppPage extends StatefulWidget {
  @override
  ShareAppState createState() => new ShareAppState();
}

class ShareAppState extends State<ShareAppPage> {
  @override
  void initState() {
    super.initState();
    Share.share(
        'Check out this app KaamKhoj https://play.google.com/store/apps/details?id=com.saishvilas.final3hd');
  }

  _launchURL() async {
    print("Done");
    // const url = 'http://www.instagram.com/kaamkhoj/'; //Working
    //  const url = 'https://www.youtube.com/channel/UCrDumaP5bEcs4keGj_hvaXg'; //Working
//   const url = 'https://www.linkedin.com/in/kaamkhoj/'; //working
//    const url = 'http://twitter.com/kaamkhoj'; //working
    const url = 'http://facebook.com/kaamkhoj';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              backgroundColor: Color.fromARGB(0xff, 0xf5, 0xea, 0xea),
              bottomNavigationBar: Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child:
                ButtonTheme(
          height: 40,
          minWidth: 290,
          child: Align(
            alignment: Alignment.center,
            child: RaisedButton(
                onPressed: () {

                        Share.share(
                            'Check out this app KaamKhoj https://play.google.com/store/apps/details?id=com.saishvilas.final3hd');
                            
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'Please Share This Again',
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
          body: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/upper.png")),
                  )),
                  Column(
                    children: <Widget>[
                      Text('Thank You For Sharinf This Application',
                      style: GoogleFonts.sourceSansPro(
                                  color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                  fontSize: 40,
                                  ),
                      ),
                      
                                        
                    ],
                  ),
              ],
            ),
            
          ),
        ),
      ),
    );
  
  }

}