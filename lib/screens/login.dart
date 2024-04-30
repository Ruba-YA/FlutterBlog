import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/api_response.dart';
import 'package:flutter_application_5/screens/loading.dart';
import 'package:flutter_application_5/screens/register.dart';
import 'package:flutter_application_5/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/user.dart';
import 'home.dart';

// login class
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
bool loading = false;
void _loginUser() async{
  ApiResponse response = await login(txtEmail.text, txtPassword.text);
  if(response.error == null){
    __saveAndRedirectToHome(response.data as User);
  }

  else
  {
    setState(() {
      loading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error!)));
  }
}
void __saveAndRedirectToHome(User user) async{
SharedPreferences pref = await SharedPreferences.getInstance();
await pref.setString('token', user.token ?? '');
await pref.setInt('userId', user.id ?? 0);
Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form( 
        key: formkey,
        child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          TextFormField(
            controller: txtEmail,
            validator: (val)=>val!.isEmpty ? "Invalid email address " : null,
            keyboardType: TextInputType.emailAddress,
            decoration: KInputDecoration('Email')
          ),
          SizedBox(height: 10,),
            TextFormField(
            controller: txtPassword,
            validator: (val)=>val!.length < 6 ? "Required at least 6 chars  " : null,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: KInputDecoration('password')
          ),
           SizedBox(height: 10,),
           loading? Center(child: CircularProgressIndicator(),):
          KTextButton("Login" ,() {
            if(formkey.currentState!.validate()){
             setState(() {
               loading = true;
                _loginUser() ;
             });

            }
          }),
          SizedBox(height: 10,),
      KLoginRegisterHint("Don't Have an Account ?  ", "Register", (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Register()), (route) => false);
      })
        ],
      )),
     
    );
  }
}