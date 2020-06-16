import 'package:mailer2/mailer.dart';

void sendMail(String tomail) {
  var options = new GmailSmtpOptions()
    ..username = 'akhati12345@gmail.com'
    ..password = 'arsenaladitya11'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'akhati12345@gmail.com'
    ..recipients.add(tomail)
//    ..bccRecipients.add('hidden@recipient.com')
    ..subject = 'Testing the Dart Mailer library'
//      ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = 'This is a cool email message. Whats up?'
    ..html = '<h1>Test</h1><p>Hey!</p>';

  // Email it.
  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}
