import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code/mainScreen.dart';

class NoFound extends StatefulWidget {
  var response;
  var result;
  NoFound({super.key, required this.response, required this.result});

  @override
  State<NoFound> createState() => _NoFoundState();
}

class _NoFoundState extends State<NoFound> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.result);
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
              "assets/splash.png",
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
              onPressed: apiPostCall,
              child: const Text(
                'Go Back',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void apiPostCall() async {
    final String url =
        "http://ecofbc.com/index.php/fbc/process_image/${widget.result}";
    final Map<String, String> headers = {
      'Authorization': 'Bearer mytoken',
      'Content-Type': 'application/json',
    };
    final String body = '{"image": ${widget.result}}';

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      // Successful response
      print(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Congurations")));
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainScreen()));
    } else {
      // Error in response
      print("Error: ${response.statusCode} - ${response.body}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Congurations")));
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainScreen()));
    }
  }
}
