import 'dart:developer';

import 'package:contactmatcher/homepage.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  String message = "Please Enter Number to Continue";
  final _formKey = GlobalKey<FormState>();
  bool isValidate = false;
  TextEditingController userNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            controller: userNumber,
            keyboardType: TextInputType.number,
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return message;
              }
              if (value.length != 11) {
                return "Enter correct number";
              }
              return null;
            }),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      userNumber: userNumber.text,
                    ),
                  ),
                );
              } else {
                log("error");
              }
            },
            child: const Text("SUBMIT"),
          ),
          Text("WELCOME!!"),
        ],
      ),
    );
  }
}
