
import 'package:flutter/material.dart';
import 'package:mailer2/mailer.dart';

import 'Mail/send_mail.dart';

class MailTest extends StatefulWidget {
  @override
  _MailpageState createState() => _MailpageState();
}

class _MailpageState extends State<MailTest> {

  String tomail="amkhati11@gmail.com";

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Mail"),
        ),
        body: RaisedButton(
          onPressed: (){
            sendMail(tomail);
          },
          child: Text("Mail"),
        ),
      );
  }


}