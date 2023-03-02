import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String statusText = "Start Server";

  startServer() async {
    setState(() {
      statusText = "Starting server on Port : 8080";
    });
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

    print("Server running on IP : ${server.address} On Port : ${server.port}");

    await for (var request in server) {
      Future<String> content = utf8.decodeStream(request);
      content.then(
          (value) => print('Request received to ${server.address} - \n$value'));

      String datetime = DateTime.now().toString();
      request.response.headers.contentType =
          ContentType("text", "plain", charset: "utf-8");
      request.response.write('Hello, world $datetime');
      request.response.close();
    }

    setState(() {
      statusText =
          "Server running on IP : ${server.address} On Port : ${server.port}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              startServer();
            },
            child: Text(statusText),
          )
        ],
      ),
    ));
  }
}
