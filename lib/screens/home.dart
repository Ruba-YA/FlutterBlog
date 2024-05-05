//Home class
import 'package:flutter/material.dart';
import 'package:flutter_application_5/screens/login.dart';
import 'package:flutter_application_5/screens/post_form.dart';
import 'package:flutter_application_5/screens/post_screen.dart';
import 'package:flutter_application_5/screens/profile.dart';
import 'package:flutter_application_5/services/user_services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0 ; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(onPressed: (){
 logout().then((value) => {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
    });

          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: currentIndex == 0 ? PostScreen() : Profile(),
      floatingActionButton: FloatingActionButton(onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>PostForm()), (route) => false);

      },
      child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: 
      BottomNavigationBar(items: [
         BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'
        ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
        label: 'Profile'
        )
      ],
      currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      )),
   



    );
  }
}