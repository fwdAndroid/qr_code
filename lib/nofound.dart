import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code/mainScreen.dart';
import 'package:qr_code/splash.dart';

class NoFound extends StatefulWidget {
  var response;
  var phoneController;
  NoFound({super.key, required this.response, required this.phoneController});

  @override
  State<NoFound> createState() => _NoFoundState();
}

class _NoFoundState extends State<NoFound> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deviceDetails();
  }

  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
          deviceVersion = build.model;
          identifier = build.supportedAbis.first;
        });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = data.name;
          deviceVersion = data.isPhysicalDevice.toString();
          identifier = data.identifierForVendor!;
        }); //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
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
              widget.phoneController,
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
                'Home Page',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
