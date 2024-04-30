import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/api_response.dart';
import 'package:flutter_application_5/models/user.dart';
import 'package:flutter_application_5/screens/login.dart';
import 'package:flutter_application_5/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response =
        await register(txtName.text, txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.error!)));
    }
  }

void _saveAndRedirectToHome(User user) async {
  print('User ID to save: ${user.id}');
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('token', user.token ?? '');
  await pref.setInt('user_id', user.id ?? 0);
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => Home()),
    (route) => false,
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
                controller: txtName,
                validator: (val) =>
                    val!.isEmpty ? "Invalid Name " : null,
                keyboardType: TextInputType.emailAddress,
                decoration: KInputDecoration('Name ')),
            SizedBox(height: 10),
            TextFormField(
                controller: txtEmail,
                validator: (val) =>
                    val!.isEmpty ? "Invalid email address " : null,
                keyboardType: TextInputType.emailAddress,
                decoration: KInputDecoration('Email')),
            SizedBox(height: 10),
            TextFormField(
                controller: txtPassword,
                validator: (val) =>
                    val!.length < 6 ? "Required at least 6 chars  " : null,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: KInputDecoration('password')),
            SizedBox(height: 10),
            loading
                ? Center(child: CircularProgressIndicator())
                : KTextButton("Register", () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      _registerUser(); // Call the registration function
                    }
                  }),
            SizedBox(height: 10),
            KLoginRegisterHint("Already have an account?  ", "Login", () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            })
          ],
        ),
      ),
    );
  }
}
