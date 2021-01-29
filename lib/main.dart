import 'package:contact_flutter/pages/dashboard_page.dart';
import 'package:contact_flutter/utils/constants.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(ContactsApp());
}

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: DrawerTitles.CONTACTS,
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new DashBoardPage(),
    );
  }
}