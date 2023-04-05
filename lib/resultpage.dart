import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ResultPage extends StatefulWidget {
  final res;
  const ResultPage({super.key, required this.res});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Forvil Cosmetics  Scanner"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/splash.png",
          )),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Result",
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            widget.res,
            style: TextStyle(color: Color(0xffffd700), fontSize: 20),
          )),
        ],
      ),
    );
  }
}
