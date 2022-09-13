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
List<Contact> _contacts = [];
List<Contact> matchedContacts = [];

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
              itemCount: matchedContacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(matchedContacts[index].displayName.toString()),
                  subtitle: Text(matchedContacts[index]
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
    log("${contacts.first.phones.first}sss");
    log("YEAH ${_contacts.where((element) {
      return element.phones.contains('03002969300');
    })}");
    matchedContacts = _contacts.where((element) {
      for (int i = 0; i < contacts.length; i++) {
        if (element.phones.contains(
          contacts[i]
              .phones
              .first
              .replaceAll("+92", "0")
              .replaceAll("-", "")
              .replaceAll(" ", ""),
        )) {
          log("${contacts[i].phones.first.replaceAll("+92", "0").replaceAll("-", "").replaceAll(" ", "")} name Name");
          return true;
        }
      }
      return false;
    }).toList();

    log("LENGTH: ${_contacts.length} ${matchedContacts.length} ${contacts.length}");

    for (int i = 0; i < matchedContacts.length; i++) {
      Services.addData(
          matchedContacts[i].displayName,
          matchedContacts[i]
              .phones
              .first
              .replaceAll("+92", "0")
              .replaceAll("-", "")
              .replaceAll(" ", ""),
          "Your phone has ${matchedContacts[i].phones.first.replaceAll("+92", "0").replaceAll("-", "").replaceAll(" ", "")} with name ${matchedContacts[i].displayName}");
    }
    print('${matchedContacts.length} Match Contacts');

    setState(() {});
  }
}
