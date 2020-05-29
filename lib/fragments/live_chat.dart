import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    launchWhatsapp();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Chat Again',
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


//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Center(
//        child: new RaisedButton(
//          onPressed:() {
//
//          },
////          onPressed: () async => await launch(
////
////               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
////              "https://wa.me/+917977763205?text=Hello"),
////        onPressed:() => _launchURL(),
//          child: Text("Thank You"),
//
//        )
//
//    );
//  }

}