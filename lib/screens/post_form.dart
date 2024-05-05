import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_5/constant.dart';
import 'package:flutter_application_5/models/api_response.dart';
import 'package:flutter_application_5/screens/home.dart';
import 'package:flutter_application_5/screens/loading.dart';
import 'package:flutter_application_5/screens/login.dart';
import 'package:flutter_application_5/screens/post_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../services/post_services.dart';
import '../services/user_services.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textbody = TextEditingController();
  bool loading = false ; 
  File? imageFile;
  final _picker = ImagePicker();
  Future getImage() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void createPost() async{
    String? image = imageFile == null ? null : getStringImage(imageFile);
    ApiResponse response = await CreatePost(textbody.text , image);
    if(response.error == null)
    {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>PostScreen()), (route) => false);
    }
    else if(response.error == unauthorized)
    {
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = !loading;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Post"),
        actions: [
          IconButton(onPressed: (){
            setState(() {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
            });
            
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: loading ? Center(child: CircularProgressIndicator(),) :  ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: imageFile == null ?null : DecorationImage(image: FileImage(imageFile ?? File('')),
              fit: BoxFit.cover
              )
            ),
            child: Center(
              child: IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.black87,
                  )),
            ),
          ),
          Form(
            key: formkey,
            child: Padding(padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: textbody,
              keyboardType: TextInputType.multiline,
              maxLines: 9,
              maxLength: 90,
              validator: (val)=>val!.isEmpty ? " Post body is required ":null,
              decoration: InputDecoration(
                hintText: 'Post body ..',
                border: OutlineInputBorder(borderSide: BorderSide(width: 1 , color: Colors.black38))
              ),
            ),
            
            ),

          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8),
          child: KTextButton('Post', (){
             if(formkey . currentState!.validate()){
            setState(() {
             loading = !loading;
            });
            createPost();
             }
          }),
          ),

        ],
      ),
    );
  }
}
