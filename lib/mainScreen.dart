import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 200,
            ),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker.platform
                    .getImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  // Step 2: Save the captured image locally
                  final file = File(pickedFile.path);

                  // Step 3: Upload the saved image using Dio
                  final dio = Dio();

                  FormData formData = FormData.fromMap({
                    "image": await MultipartFile.fromFile(file.path),
                  });

                  final response = await dio.post(
                    "https://ecofbc.com/index.php/fbc/process_image/",
                    data: formData,
                  );

                  // Step 4: Handle the response
                  if (response.statusCode == 200) {
                    print(response.data);
                    if (response.data == null) {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("OOP'S "),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Image.asset("assets/wrong.png"),
                                  Text(
                                      'Apka Bheja gaya code ddd durust nahi, hamaray maujoda codes mai yeh code maujod nahi. Apka product nakli hai.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (response.data == "USED") {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Already Used"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Image.asset("assets/used.png"),
                                  Text(
                                      'Naqqalon se hoshiar! Hum maazrat khuwah hain, yeh code phele bhi istemal ho chukka hay.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (response.data == "AUTHENTIC") {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Authenticate"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Image.asset("assets/check.png"),
                                  Text(
                                      'Moazziz Sarif! Apka code 640262EEA030608771 aur serial number yeh hai, Aap ney asli Product khareedi hai.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    print("Upload successful");
                  } else if (response.statusCode == 400) {
                    print(response.statusMessage);
                    print("Upload failed");
                  }
                } else {
                  print("User canceled the picker");
                }
              },
              child: Text(
                "Scan QRCODE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
