import 'package:flutter/material.dart';
import 'package:flutter_application_5/constant.dart';
import 'package:flutter_application_5/models/api_response.dart';
import 'package:flutter_application_5/screens/login.dart';
import 'package:flutter_application_5/services/post_services.dart';
import 'package:flutter_application_5/services/user_services.dart';

import '../models/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> postList = [];
  int userId = 0 ;
  bool loading = true;
// get all posts

Future<void> retrivePosts() async{
  userId = await getUserId();
  ApiResponse response = await getPosts();
  if(response.error == null)
  {
    setState(() {
      postList = response.data as  List<dynamic>;
      // loading = loading ? !loading : loading;

    });
  }

  else if(response.error == unauthorized )
  {
     logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
  }
  else
  {
   
  }
}

  @override
  void initState() {
    // TODO: implement initState
    retrivePosts();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: !loading ? Center(child:  CircularProgressIndicator()) :
      ListView.builder(
        itemCount: postList.length,
        itemBuilder: (BuildContext context, int index) {
          Post post = postList[index];
          return Text('${post.body}', style: TextStyle(color: Colors.black),);
        },
      ));
  }
}