// get all posts 
import 'dart:convert';
import 'package:flutter_application_5/constant.dart';
import 'package:flutter_application_5/services/user_services.dart';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../models/post.dart';
Future<ApiResponse> getPosts() async{
ApiResponse apiResponse = ApiResponse();
try{
  String token = await getToken();
  final response = await http.get(Uri.parse(postsURL),
  headers: {
   'Accept': 'application/json',
   'Authorization': 'Bearer $token'
  });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['posts'].map((p)=>Post.fromJson(p)).toList();
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
// Create Post 
Future<ApiResponse> CreatePost(String body , String? image) async{
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
    final response = await http.post(Uri.parse(postsURL),
      headers: {
   'Accept': 'application/json',
   'Authorization': 'Bearer $token'
  },body: image !=null ?{
    'body': body,
    'image': image
  } : {
    'body': body
  }
  
  );

switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
      final errors = jsonDecode(response.body)['errors'];
      apiResponse.error = errors[errors.key.elementAt(0)][0];
        break;
case 401:
apiResponse.error = unauthorized;
      default:
        apiResponse.error = somethingwentwrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;


  }

  // Edit Post

  Future<ApiResponse> editPost(int postId, String body) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.put(Uri.parse('$postsURL/$postId'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body:  {
            'body': body,
          
          });

          switch (response.statusCode) {
            case 200:
              apiResponse.data = jsonDecode(response.body)['message'];
              break;
            case 403:
               apiResponse.data = jsonDecode(response.body)['message'];

              break;
            case 401:
              apiResponse.error = unauthorized;
              break;
            default:
              apiResponse.error = somethingwentwrong;
          }
    }
    catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

// Delete Post

Future <ApiResponse> deletePost(int postId) async{
      ApiResponse apiResponse = ApiResponse();
      try{

      
      String token = await getToken();
      final response = await http.put(Uri.parse('$postsURL/$postId'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

          
          switch (response.statusCode) {
            case 200:
              apiResponse.data = jsonDecode(response.body)['message'];
              break;
            case 403:
               apiResponse.data = jsonDecode(response.body)['message'];

              break;
            case 401:
              apiResponse.error = unauthorized;
              break;
            default:
              apiResponse.error = somethingwentwrong;
          }
    }
    catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }



