import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pa3/Pages/cd.dart';
import 'package:pa3/Pages/vaccine.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Menu extends StatelessWidget{
  Map<String, String> arguments;
  Menu({Key key, @required this.arguments}) : super(key: key);
  Map<String, String> result;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.coronavirus_outlined),
              title: Text('Cases/Deaths'),
              onTap: () async {
                Navigator.push( context,
                  MaterialPageRoute(
                      builder: (context) => Cd(arguments: {"id": arguments["id"], "page": "Menu", })
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('Vaccine'),
              onTap: () async {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Vaccine(arguments: {
                            "id": arguments["id"],
                            "page": "Menu",
                          })
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Welcome! '+arguments["id"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 380.0),
                  ),
                  Container(
                    child: Text(
                      'Previous: '+arguments["page"]+' Page',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    ),
    );
  }
}