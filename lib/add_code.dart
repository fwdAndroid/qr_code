import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddCode extends StatefulWidget {
  const AddCode({super.key});

  @override
  State<AddCode> createState() => _AddCodeState();
}

class _AddCodeState extends State<AddCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Adding QRCODE"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
