import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_5/models/api_response.dart';
import 'package:flutter_application_5/screens/login.dart';
import 'package:flutter_application_5/services/user_services.dart';
import 'package:path/path.dart';

import '../constant.dart';
import 'home.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _loadUserInfo() async {
    String token = await getToken(); 
    if (token == '') {
      
      Navigator.of(context as BuildContext).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
    }
    else {
      ApiResponse response = await getUserDetail();
      if(response.error == null) {
        Navigator.of(context as BuildContext).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
      }
      else if(response.error == unauthorized) {
        Navigator.of(context as BuildContext).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
      }
      else{
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(content: Text('${response.error}'),));
      }
    }
  }
 @override
  void initState() {
    // TODO: implement initState
    _loadUserInfo();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}