import 'dart:developer';
import 'package:contactmatcher/firebase_contacts.dart';
import 'package:contactmatcher/match_contacts.dart';
import 'package:contactmatcher/services.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts = [];
  List<Contact> _contacts = const [];
  List<FirebaseContacts> fireBaseContact = [];

  String? _text;
  @override
  initState() {
    // getData();
    initPlatformState();

    // TODO: implement initState
    super.initState();
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await Permission.contacts.request();

      List<Contact> contacts = await FastContacts.allContacts;
      // contacts = contacts.where((element) {
      //   return contacts.c
      // }).toList();
      _contacts = contacts;

      log(_contacts.length.toString() + " contacts");
    } on PlatformException catch (e) {
      _text = 'Failed to get contacts:\n${e.details}';
    }

    if (!mounted) return;

    // _contacts = _contacts.where((element) {
    //   return contacts.contains(element);
    // }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // getData();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MatchContacts(
                        contacts: _contacts,
                      )));
        },
        child: const Icon(Icons.contacts),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _contacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // log("${_contacts[index].phones.first} phones");

                return ListTile(
                  title: Text(_contacts[index].displayName),
                  subtitle: Text(_contacts[index].phones.isEmpty
                      ? " NO Number"
                      : _contacts[index]
                          .phones
                          .first
                          .replaceAll("+92", "0")
                          .replaceAll("-", "")
                          .replaceAll(" ", "")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // getData() async
  //   contacts = await Services.getContacts();
  //   log(contacts.toString() + "sss");
  //   _contacts = _contacts.where((element) {
  //     for (int i = 0; i < contacts.length; i++) {
  //       if (element.phones.contains(contacts[i].phones.last)) {
  //         log(contacts[i].phones.last + " name Name");
  //         return true;
  //       }
  //     }
  //     return false;
  //   }).toList();
  //   for (int i = 0; i < _contacts.length; i++) {
  //     Services.addData(_contacts[i].displayName, _contacts[i].phones.last);
  //   }
  //   print('${_contacts.length} HEHE');
  //   // log(contcts.length.toString());
  //   // FirebaseContacts(
  //   //     displayName: contacts[index].name!,
  //   //     id: contacts[index].id as String,
  //   //     phones: [contacts[index].number as String]);
  //   // log("${contactss!.values.toList()} + asas ");
  //   setState(() {});
  // }
}
