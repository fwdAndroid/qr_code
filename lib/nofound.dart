import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code/mainScreen.dart';
import 'package:qr_code/splash.dart';

class NoFound extends StatefulWidget {
  var response;
  NoFound({
    super.key,
    required this.response,
  });

  @override
  State<NoFound> createState() => _NoFoundState();
}

class _NoFoundState extends State<NoFound> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              height: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "*Welcome to Faiza Beauty Cream Product Authentication System* Result of your search is: بھیجے ہوے کوڈ کا رزلٹ یہ ہے ,",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              widget.response,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Center(
              child: Text(
                "Powered By: EcoWebPortals.com",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, fixedSize: Size(150, 30)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => Splash()));
              },
              child: const Text(
                'Return To Home Page',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
