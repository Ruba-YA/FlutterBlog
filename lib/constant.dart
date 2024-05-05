// here our endpoint 3 step

//3
// STRINGS
import 'package:flutter/material.dart';

const baseURL = "http://192.168.1.109:8000/api"; 
const loginURL = baseURL + "/login";
const registerURL = baseURL + "/register";
const userURL = baseURL + "/user";
const postsURL = baseURL + "/posts";
const commentsURL = baseURL + "/comments";
const logoutURL = baseURL + "/logout";

// ERRORS
const serverError = "Server Error";
const unauthorized = "Unauthorized";
const somethingwentwrong = "Something went wrong, try again later";

InputDecoration KInputDecoration(String label){
  return InputDecoration(
              labelText:label,
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(borderSide: BorderSide(width: 1 , color: Colors.black12))
            );
}

TextButton KTextButton (String label , Function  onPressed) 
{
   return TextButton(onPressed: ()=>onPressed(), child: Text(label, style: TextStyle(color: Colors.white),),
           style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical: 10))
           ),
           );
}

// LoginRegister Hint 

Row KLoginRegisterHint(String text ,  String label , Function onTap)
{
  return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text), 
              GestureDetector(
                child: Text(label , style: TextStyle(color: Colors.blue),),
                onTap: () => onTap(),
              )
            ],);
}