import 'dart:developer';

import 'package:contactmatcher/services.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

class MatchContacts extends StatefulWidget {
  MatchContacts({
    super.key,
    this.contacts,
  });
  List<Contact>? contacts;

  @override
  State<MatchContacts> createState() => _MatchContactsState();
}

List<Contact> contacts = [];
List<Contact> _contacts = const [];

class _MatchContactsState extends State<MatchContacts> {
  @override
  void initState() {
    _contacts = widget.contacts!;
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Matched Contacts"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _contacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_contacts[index].displayName.toString()),
                  subtitle: Text(_contacts[index]
                      .phones
                      .first
                      .replaceAll("+92", "0")
                      .replaceAll("-", "")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    contacts = await Services.getContacts();
    log(contacts.toString() + "sss");
    _contacts = _contacts.where((element) {
      for (int i = 0; i < contacts.length; i++) {
        if (element.phones.contains(contacts[i]
            .phones
            .first
            .replaceAll("+92", "0")
            .replaceAll("-", ""))) {
          log(contacts[i].phones.first + " name Name");
          return true;
        }
      }
      return false;
    }).toList();

    for (int i = 0; i < _contacts.length; i++) {
      Services.addData(
          _contacts[i].displayName,
          _contacts[i].phones.first.replaceAll("+92", "0").replaceAll("-", ""),
          "Your phone has ${_contacts[i].phones.first.replaceAll("+92", "0").replaceAll("-", "")} with name ${_contacts[i].displayName}");
    }
    print('${_contacts.length} HEHE');
    // log(contcts.length.toString());
    // FirebaseContacts(
    //     displayName: contacts[index].name!,
    //     id: contacts[index].id as String,
    //     phones: [contacts[index].number as String]);

    // log("${contactss!.values.toList()} + asas ");
    setState(() {});
  }
}
