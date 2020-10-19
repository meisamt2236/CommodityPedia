import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

class AddScreen extends StatelessWidget {
  static const String id = 'add_route';

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    //List<int> bytesImage = [];
    String encodedImage = '';
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ارسال محصول',
              style:
                  TextStyle(fontSize: 30, fontFamily: 'IRANSansMobile_Medium'),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.camera),
                  iconSize: 50,
                  onPressed: () async {
                    final _picker = ImagePicker();
                    PickedFile image = await _picker.getImage(
                      source: ImageSource.gallery,
                      maxWidth: 1000,
                      maxHeight: 1000,
                    );
                    final bytesImage = await image.readAsBytes();
                    String base64Encode(List<int> bytes) =>
                        base64.encode(bytes);
                    encodedImage = base64Encode(bytesImage);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'عنوان'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'توضیحات',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: priceController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'قیمت',
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final token = prefs.getString('token');
                  final id = prefs.getString('id');
                  final url = 'http://127.0.0.1:8080/post/' + id;
                  String title = titleController.text;
                  String description = descriptionController.text;
                  String price = priceController.text;

                  var data = jsonEncode({
                    "title": title,
                    "description": description,
                    "price": price,
                    "photos": encodedImage
                  });
                  final response = await http.post(url, body: data, headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer $token',
                  });
                  if (response.statusCode == 200) {
                    titleController.clear();
                    descriptionController.clear();
                    priceController.clear();
                    Navigator.pushNamed(context, MainScreen.id);
                  } else {
                    String data = response.body;
                    
                    var decodedData = jsonDecode(data);
                    print(decodedData);
                    Flushbar(
                      title: "خطا",
                      message: decodedData['error']['errors']['title']['message'],
                      duration: Duration(seconds: 3),
                      margin: EdgeInsets.all(8),
                      borderRadius: 20,
                    )..show(context);
                  }
                },
                child: Text('ارسال'),
                textColor: Colors.white,
                color: Colors.orangeAccent,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
