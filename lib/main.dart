import 'package:flutter/material.dart';
import 'package:pa3/Pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pa3/Pages/vaccine.dart';
import 'package:pa3/Pages/cd.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TableProvider()),
          ChangeNotifierProvider(create: (context) => ChartProvider()),
          ChangeNotifierProvider(create: (context) => TableProvider2()),
          ChangeNotifierProvider(create: (context) => ChartProvider2()),
        ],
        child: MaterialApp(
          title: 'Navigator',
          home: MyApp(),
        ),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String _main = "Login Please...";
  MyApp({Key key, this.title}) : super(key: key);
  final String title;
  final idController = TextEditingController();
  final pwdController = TextEditingController();

  String get _id => idController.text;
  String get _pwd => pwdController.text;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TableProvider()),
          ChangeNotifierProvider(create: (context) => ChartProvider()),
          ChangeNotifierProvider(create: (context) => TableProvider2()),
          ChangeNotifierProvider(create: (context) => ChartProvider2()),
        ],
    child:  MaterialApp(
      title: "2019314656 LeeHyunjeong",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Scaffold(
        appBar: AppBar(title: Text('2019314656 LeeHyunjeong'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    'CORONA LIVE',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  '$_main',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 50.0),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0),),
                ),
                padding: const EdgeInsets.all(20.0),
                width: 300,
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ID: ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                              width: 150,
                              child: TextField(
                                controller: idController,
                              )
                          ),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("PW: ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                              width: 150,
                              child: TextField(
                                controller: pwdController,
                              )
                          ),
                        ]
                    ),
                    ElevatedButton(
                      child: Text("Login"),
                      onPressed: () async {
                        if ((_pwd == "1234") && (_id == "skku")) {
                          Navigator.push( context,
                            MaterialPageRoute(
                                builder: (context) => Login(arguments: {"id": '$_id', "title": "2019314656 LeeHyunjeong",})
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
