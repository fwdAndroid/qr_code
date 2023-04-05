import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code/nofound.dart';
import 'package:http/http.dart' as http;

class Found extends StatefulWidget {
  String result;

  Found({super.key, required this.result});

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> {
  bool _isLoading = false;
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Text(
                "Enter Code",
                textAlign: TextAlign.start,
              )),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20),
            child: TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              obscureText: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Text(
                "Enter Phone Number",
                textAlign: TextAlign.start,
              )),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              obscureText: false,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, fixedSize: Size(150, 50)),
                    onPressed: callApi,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void callApi() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse(
        'https://www.ecofbc.com/index.php/fbc/whatsapp_authenticate_scratch_code/${phoneController.text}/${codeController.text}');

    final response = await http.get(url);
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      if (codeController.text.isNotEmpty) {
        String mainString = response.body;
        int pos = mainString.indexOf("nakli");
        if (pos == mainString.indexOf("nakli")) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "OOP's",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  content: Container(
                    height: 300,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/wrong.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          response.body,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => NoFound(
                                        response: response.body,
                                      )));
                        },
                        child: Text("OK"))
                  ],
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Congratulations",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  content: Container(
                    height: 300,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/check.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          response.body,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => NoFound(
                                        response: response.body,
                                      )));
                        },
                        child: Text("OK"))
                  ],
                );
              });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No Code Found: Code is Required")));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
