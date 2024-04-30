//Home class
import 'package:flutter/material.dart';
import 'package:flutter_application_5/screens/login.dart';
import 'package:flutter_application_5/services/user_services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: 
    TextButton(
  onPressed: () async {
    await logout().then((value) => {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
    }); // Await the logout functio
    // Add any additional logic after logout if needed
  },
  child: Text(
    'Home: Press to logout',
    style: TextStyle(fontSize: 30),
  ),
)


    );
  }
}