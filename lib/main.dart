import 'package:contactmatcher/contacts_model.dart';
import 'package:contactmatcher/homepage.dart';
import 'package:contactmatcher/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(" Contacts Matcher"),
        ),
        body: const HomePage(),
      ),
    );
  }
  
}
