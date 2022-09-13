import 'package:fast_contacts/fast_contacts.dart';

class FirebaseContacts extends Contact {
  FirebaseContacts(
      {required this.displayName, required this.phones, required this.id});

  String id;
  String displayName;
  List<String> phones;

  @override
  // TODO: implement emails
  List<String> get emails {
    return emails;
  }

  @override
  // TODO: implement structuredName
  StructuredName? get structuredName {
    return structuredName;
  }
}
