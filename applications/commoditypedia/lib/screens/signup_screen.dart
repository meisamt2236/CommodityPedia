import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatelessWidget {
  static const String id = 'signup_route';

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'دایرالکالا',
                    style: TextStyle(
                        fontSize: 80, fontFamily: 'IRANSansMobile_Bold'),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80,
                        fontFamily: 'IRANSansMobile_Bold',
                        color: Colors.orangeAccent),
                  ),
                ],
              ),
              Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'نام کاربری'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'ایمیل'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'رمز عبور'),
                  ),
                ],
              ),
              Container(
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      const url = 'http://127.0.0.1:8080/signup';
                      String username = usernameController.text;
                      String email = emailController.text;
                      String password = passwordController.text;
                      var data = jsonEncode({
                        "username": username,
                        "email": email,
                        "password": password
                      });
                      final response =
                          await http.post(url, body: data, headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                      });
                      if (response.statusCode == 200) {
                        String data = response.body;
                        var decodedData = jsonDecode(data);
                        Flushbar(
                          title: "خطا",
                          message: decodedData['error'],
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(8),
                          borderRadius: 20,
                        )..show(context);
                      } else {
                        String data = response.body;
                        var decodedData = jsonDecode(data);
                        Flushbar(
                          title: "خطا",
                          message: decodedData['error'],
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(8),
                          borderRadius: 20,
                        )..show(context);
                      }
                    },
                    child: Text('ورود'),
                    textColor: Colors.white,
                    color: Colors.orangeAccent,
                    padding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
