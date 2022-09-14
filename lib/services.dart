import 'dart:developer';
import 'package:contactmatcher/contacts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactmatcher/firebase_contacts.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_core/firebase_core.dart';

class Services {
  static DocumentReference _ref =
      FirebaseFirestore.instance.collection("Contacts").doc("appData");

  static Future<List<Contact>> getContacts() async {
    DocumentSnapshot data = await _ref.get();
    List<FirebaseContacts> contacts = [];

    Map listData = data.data() as Map;
    // print('DATA: ${listData.runtimeType} ');

    // contacts = List.castFrom<dynamic, Contact>(listData.values.toList());
    log("${listData}");
    final keys = listData.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      contacts.add(FirebaseContacts(
        displayName: listData[keys[i]]['Name'],
        phones: [listData[keys[i]]['Number'].toString()],
        id: 'id',
      ));
    }
    print('NAAAAAM: ${contacts.first.displayName}');
    return contacts;
  }

  static addData(
      String? name, String? number, String? text, String? userNumber) async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection("Contacts")
        .doc("${userNumber} Matched Contacts ");

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Contacts')
        .doc("${userNumber} Matched Contacts ")
        .get();

    if (querySnapshot.exists) {
      await ref.update({
        "${name} ${number}": {
          "Name": name,
          "Number": number,
          "Text": text,
        },
      });
    } else {
      await ref.set({
        "${name} ${number}": {
          "Name": name,
          "Number": number,
          "Text": text,
        },
      });
    }
  }

  // static fetchContacts() async {
  //   final contacts = await FastContacts.allContacts;
  //   print(contacts.length);
  //   return contacts;
  // }
}
