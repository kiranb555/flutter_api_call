import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
//Step1 :  import packages like http and async and convert from dart

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//step2 : creat a  async class of type Future<String>
// make a api call in it

  var data;

  Future<String> getData() async {
    //can define var or http.Response
    var response = await http.get("https://api.covid19api.com/summary",
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      // convert the data into json using Dart json converter
      var responseData = convert.jsonDecode(response.body);

      setState(() {
        data = responseData["Countries"];
      });

      print("api call succes");
      print(responseData);
    } else {
      print("api call failed");
    }
  }

//calling api class when file loaded
  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Card(
              child: Text(
                item["Country"].toString(),
              ),
            );
          },
        ),
      ),
    ));
  }
}
