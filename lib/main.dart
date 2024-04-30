import 'package:flutter/material.dart';
import 'package:flutter_application_5/screens/loading.dart';
import 'package:flutter_application_5/screens/login.dart';

void main() {
  runApp(
   
    MyBlogApp(),
    );
 
}

class MyBlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      
    );
  }
}
// /* P