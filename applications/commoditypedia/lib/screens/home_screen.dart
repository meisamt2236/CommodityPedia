import 'package:commoditypedia/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:commoditypedia/utilities/convertor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _HomeScreenMobile(),
          desktop: _HomeScreenDesktop(),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatefulWidget {
  @override
  __HomeScreenMobileState createState() => __HomeScreenMobileState();
}

class __HomeScreenMobileState extends State<_HomeScreenMobile> {
  var decodedData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    const url = 'http://127.0.0.1:8080/posts';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      String data = response.body;
      setState(() {
        decodedData = jsonDecode(data)['posts'];
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'دایرالکالا',
            style: TextStyle(
              fontSize: 28,
              color: Colors.blue[700],
              fontFamily: 'IRANSansMobile_Medium',
            ),
          ),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 8),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          decodedData.length == 0
                              ? new Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                )
                              : decodedData[index]['creator']['image'] != null
                                  ? new Image.network(
                                      '${decodedData[index]['creator']['image']}',
                                      width: 30,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          AssetImage('images/user.png'),
                                    ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                decodedData.length == 0
                                    ? new Container(
                                        width: 50,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    : new Text(
                                        '${decodedData[index]['creator']['username']}',
                                        style: TextStyle(
                                          fontFamily: 'IRANSansMobile_Medium',
                                        ),
                                      ),
                                decodedData.length == 0
                                    ? new Container(
                                        width: 70,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    : new Text(
                                        '${dateConvertor(decodedData[index]['date'])}'),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () => print('More'),
                          ),
                        ],
                      ),
                    ),
                    decodedData.length == 0
                        ? new Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                          )
                        : new Image.network(
                              '${decodedData[index]['photo_address']}',
                              width: MediaQuery.of(context).size.width,
                            ) ??
                            Text('null'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () => print('Like'),
                                ),
                                decodedData.length == 0
                                    ? new Container(
                                        width: 30,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    : new Text(
                                        '۱۲',
                                        style: TextStyle(
                                          fontFamily: 'IRANSansMobile_Medium',
                                        ),
                                      ),
                                IconButton(
                                  icon: Icon(Icons.comment),
                                  onPressed: () => print('Comment'),
                                ),
                                decodedData.length == 0
                                    ? new Container(
                                        width: 30,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    : new Text(
                                        '۳۴',
                                        style: TextStyle(
                                          fontFamily: 'IRANSansMobile_Medium',
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          decodedData.length == 0
                              ? new Container(
                                  width: 40,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                )
                              : new Text(
                                  '${priceConvertor(decodedData[index]['price'])} تومان'),
                          IconButton(
                            icon: Icon(Icons.bookmark),
                            onPressed: () => print('Bookmark'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: decodedData.length == 0
                          ? new Container(
                              width: 70,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            )
                          : new Text(
                              '${decodedData[index]['title']}',
                              style: TextStyle(
                                  fontFamily: 'IRANSansMobile_Medium'),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: decodedData.length == 0
                          ? new Container(
                              width: 150,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            )
                          : new Text('${decodedData[index]['description']}'),
                    ),
                  ],
                ),
              );
            },
            childCount: decodedData.length == 0 ? 1 : decodedData.length,
          ),
        ),
      ],
    );
  }
}

class _HomeScreenDesktop extends StatefulWidget {
  @override
  __HomeScreenDesktopState createState() => __HomeScreenDesktopState();
}

class __HomeScreenDesktopState extends State<_HomeScreenDesktop> {
  var decodedData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response =
        await http.get('http://127.0.0.1:8000/api/commodity_api/');
    if (response.statusCode == 200) {
      String data = utf8.decode(response.bodyBytes);
      decodedData = jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(),
        ),
        Spacer(),
        Container(
          width: 600,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/batman.jpg'),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${decodedData[index]['user']['username']}',
                                        style: TextStyle(
                                          fontFamily: 'IRANSansMobile_Medium',
                                        ),
                                      ),
                                      Text(
                                          '${dateConvertor(decodedData[index]['date'])}'),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  onPressed: () => print('More'),
                                ),
                              ],
                            ),
                          ),
                          Image.network(
                            '${decodedData[index]['image']}',
                            width: MediaQuery.of(context).size.width,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.favorite),
                                        onPressed: () => print('Like'),
                                      ),
                                      Text('۱۲'),
                                      IconButton(
                                        icon: Icon(Icons.comment),
                                        onPressed: () => print('Comment'),
                                      ),
                                      Text('۳۴'),
                                    ],
                                  ),
                                ),
                                Text(
                                    '${priceConvertor(decodedData[index]['price'])} تومان'),
                                IconButton(
                                  icon: Icon(Icons.bookmark),
                                  onPressed: () => print('Bookmark'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${decodedData[index]['title']}',
                              style: TextStyle(
                                  fontFamily: 'IRANSansMobile_Medium'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('${decodedData[index]['description']}'),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 2,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Flexible(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
