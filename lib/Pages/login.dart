import 'package:flutter/material.dart';
import 'package:pa3/Pages/menu.dart';

class Login extends StatelessWidget{
  final Map<String, String> arguments;
  Login({Key key, @required this.arguments}) : super(key: key);
  String _imagepath = "assets/images/main.jpg";
  //Login(this.arguments);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("2019314656 LeeHyunjeong"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'CORONA LIVE',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'Login Success. Hello '+arguments["id"]+'!!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],)
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: 300,
                height: 150,
                child:
                Image.asset(_imagepath),
              ),
              //margin: const EdgeInsets.only(bottom: 100.0),
            ),
            ElevatedButton(
              child: Text("Start CORONA LIVE"),
              onPressed: () async {
                Navigator.push( context,
                  MaterialPageRoute(
                      builder: (context) => Menu(arguments: {"id": arguments["id"], "page": "Login", })
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
