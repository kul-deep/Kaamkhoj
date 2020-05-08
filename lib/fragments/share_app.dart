import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class ShareAppPage extends StatelessWidget {
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
        onPressed:() => _launchURL(),
        child: Text("Aditya"),

    )

    );
  }

}