// step 4

import 'dart:convert';
//import http package
import 'package:http/http.dart' as http;
import 'package:flutter_application_5/constant.dart';
import 'package:flutter_application_5/models/api_response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
// login 
Future <ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
   final response = await post(
     Uri.parse(loginURL),
     headers: {
       'Accept': 'application/json'
     },
     body: {
       'email': email,
       'password': password 
     }
   );
   switch(response.statusCode){
     case 200:
       apiResponse.data = User.fromJson(jsonDecode(response.body));
       break;
     case 422:
       final errors = jsonDecode(response.body)['errors'];
       apiResponse.error = errors[errors.keys.elementAt(0)][0];
       break;
     case 403:
       apiResponse.error = jsonDecode(response.body)['message'];
       break;
     default:
       apiResponse.error = somethingwentwrong;
   }
    
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// register
Future <ApiResponse> register(String name, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
   final response = await http.post(
     Uri.parse(registerURL),
     headers: {
       'Accept': 'application/json'
     },
     body: {
       'name': name,
       'email': email,
       'password': password 
     }
   );
   switch(response.statusCode){
     case 200:
       apiResponse.data = User.fromJson(jsonDecode(response.body));
       break;
     case 422:
       final errors = jsonDecode(response.body)['errors'];
       apiResponse.error = errors[errors.keys.elementAt(0)][0]; 
       break;
     default:
       apiResponse.error = somethingwentwrong;
   }
    
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// get user data
Future <ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
   String token = await getToken();
   final response = await http.get(
     Uri.parse(userURL),
     headers: {
       'Accept': 'application/json',
       'Authorization': 'Bearer $token'
     }
   );
   switch(response.statusCode){
     case 200:
       apiResponse.data = User.fromJson(jsonDecode(response.body));
       break;
     case 401:
       apiResponse.error = unauthorized;
       break;
     default:
       apiResponse.error = somethingwentwrong;
   }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// get token
Future <String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}


// get user id
Future <int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('user_id') ?? 0;
}

// logout
Future <bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('token');
}
