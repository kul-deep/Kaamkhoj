import 'dart:io';

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
    ..from = 'customercare@kaamkhoj.co.in'
    ..recipients.add(tomail)
//    ..bccRecipients.add('hidden@recipient.com')
    ..subject = 'Welcome to Kaamkhoj'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = 'This is a cool email message. Whats up?'
    ..html = '<h1>Hi Aditya,</h1><p>The complete team at kaamkhoj are pleased to receive your inquiry and look forward to serve you in future.We will get in touch with you shortly.</p> <h1>Thanks</h1> h1>Alisha Rai</h1> <h1>Customer Loyalty Executive</h1> <h1>022-66661314</h1>';

  // Email it.
  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}


void sendMailAdmin() {
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
    ..recipients.add('Clopes024@gmail.com')
//    ..bccRecipients.add('hidden@recipient.com')
    ..subject = 'Testing the Dart Mailer library'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = 'This is a cool email message. Whats up?'
    ..html = '<h1>Test</h1><p>Hey!</p>';

  // Email it.
  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}



void sendMailContacts(String tomail,File file1) {
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
    ..subject = 'Contacts of User from Kaamkhoj App'
    ..attachments.add(new Attachment(file: file1))
    ..text = 'This is a cool email message. Whats up?'
    ..html = '<h1>Hi Admin, </h1> <p>this is the mail of contacts of User from Kaamkhoj App</p>';

  // Email it.
  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}


void sendMailReceipt(String tomail,File file1) {
  print(tomail);
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
    ..subject = 'Contacts of User from Kaamkhoj App'
    ..attachments.add(new Attachment(file: file1))
    ..text = 'This is a cool email message. Whats up?'
    ..html = '<h1>Hi Admin, </h1> <p>this is the mail has receipt of 1000</p>';

  // Email it.
  emailTransport.send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

