import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

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
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/thankyou.png")),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ButtonTheme(
            height: 40,
            minWidth: MediaQuery
                .of(context)
                .size
                .width,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                  onPressed: () {
                    Share.share(
                        'Check out this app KaamKhoj https://play.google.com/store/apps/details?id=com.saishvilas.final3hd');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Share More',
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
      ),
    );
  }
}