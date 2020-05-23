import 'package:flutter/material.dart';
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
    Share.share('Check out this app KaamKhoj https://play.google.com/store/apps/details?id=com.saishvilas.final3hd');
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
    // TODO: implement build
    return new Center(
      child: new RaisedButton(
        onPressed:() {
          Share.share('Check out this app KaamKhoj https://play.google.com/store/apps/details?id=com.saishvilas.final3hd');
        },
//          onPressed: () async => await launch(
//
////               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
//              "https://wa.me/+917977763205?text=Hello"),
//        onPressed:() => _launchURL(),
        child: Text("Aditya"),

    )

    );
  }

}