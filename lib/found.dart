import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code/nofound.dart';
import 'package:http/http.dart' as http;

class Found extends StatefulWidget {
  // final response;
  Found({
    super.key,
  });

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> {
  bool _isLoading = false;
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // String num = "+923364540037";

  @override
  Widget build(BuildContext context) {
    // phoneController.text = num;
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
              decoration: InputDecoration(hintText: "0000"),
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

    if (phoneController.text.isEmpty) {
      final url = Uri.parse(
          'https://www.ecofbc.com/index.php/fbc/whatsapp_authenticate_scratch_code/${00000}/${codeController.text}/forvil');

      final response = await http.get(url);
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        if (codeController.text.isNotEmpty) {
          String mainString = response.body;
          int pos = mainString.indexOf("nakli");
          int post = mainString.indexOf("asli");
          if (pos == mainString.indexOf("nakli")) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("OOP'S"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Image.asset("assets/wrong.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            response.body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => NoFound(
                                        response: response.body,
                                        phoneController: "00000",
                                      )));
                        },
                        child: Text("OK"))
                  ],
                );
              },
            );
          } else if (post == mainString.indexOf("asli")) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Success"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Image.asset("assets/check.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            response.body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => NoFound(
                                        response: response.body,
                                        phoneController: "00000",
                                      )));
                        },
                        child: Text("OK"))
                  ],
                );
              },
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No Code Found: Code is Required")));
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } else {
      final url = Uri.parse(
          'https://www.ecofbc.com/index.php/fbc/whatsapp_authenticate_scratch_code/${phoneController.text}/${codeController.text}/forvil');

      final response = await http.get(url);
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        if (codeController.text.isNotEmpty) {
          String mainString = response.body;

          if (response.body.contains('asli')) {
            print("asli");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: ListBody(
                      children: [Text(response.body)],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => NoFound(
                                          response: response.body,
                                          phoneController: phoneController.text,
                                        )));
                          },
                          child: Text("OK"))
                    ],
                  );
                });
          } else if (response.body.contains('nakli')) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: ListBody(
                      children: [Text(response.body)],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => NoFound(
                                          response: response.body,
                                          phoneController: phoneController.text,
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
}
