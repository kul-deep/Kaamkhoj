import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class LiveChatPage extends StatefulWidget {
  @override
  LiveChatState createState() => new LiveChatState();
}

class LiveChatState extends State<LiveChatPage> {



  @override
  void initState()  {
    super.initState();
    launchWhatsapp();

  }
  launchWhatsapp() async {
  await launch(
//               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
  "https://wa.me/+917977763205?text=Hello");}



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
        child: new RaisedButton(
          onPressed:() {
            
          },
//          onPressed: () async => await launch(
//
////               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
//              "https://wa.me/+917977763205?text=Hello"),
//        onPressed:() => _launchURL(),
          child: Text("Thank You"),

        )

    );
  }

}