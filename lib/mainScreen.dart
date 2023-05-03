import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qr_code/found.dart';
import 'package:qr_code/nofound.dart';

class MainScreen extends StatefulWidget {
  //final CameraDescription camera;
  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // late CameraController _controller;
  // late Future<void> _initializeControllerFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   // To display the current output from the Camera,
  //   // create a CameraController.
  //   _controller = CameraController(
  //     // Get a specific camera from the list of available cameras.
  //     widget.camera,
  //     // Define the resolution to use.
  //     ResolutionPreset.medium,
  //   );

  //   // Next, initialize the controller. This returns a Future.
  //   _initializeControllerFuture = _controller.initialize();
  // }

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
            // Container(
            //   height: 300,
            //   margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            //   child: FutureBuilder<void>(
            //     future: _initializeControllerFuture,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         // If the Future is complete, display the preview.
            //         return CameraPreview(_controller);
            //       } else {
            //         // Otherwise, display a loading indicator.
            //         return const Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async {
                // await _initializeControllerFuture;
                // final image = await _controller.takePicture();
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoFound(
                          response: response.data,
                          // Pass the automatically generated path to
                          // the DisplayPictureScreen widget.
                        ),
                      ),
                    );
                    print("Upload successful");
                  } else if (response.statusCode == 400) {
                    print(response.statusMessage);
                    print("Upload failed");
                  }
                } else {
                  print("User canceled the picker");
                } // If the picture was taken, display it on a new screen.

                // Navigator.push(
                //     context, MaterialPageRoute(builder: (builder) => Found()));
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

  // void _captureImage() async {
  //   try {
  //     // await _initializeControllerFuture;

  //     // // Take the picture and retrieve the file path
  //     // final path = await _controller.takePicture();

  //     // // Post the image to the server
  //     // final response = await http.post(
  //     //   Uri.parse('https://ecofbc.com/index.php/fbc/process_image/'),
  //     //   body: {
  //     //     'image': base64Encode(File(path.path).readAsBytesSync()),
  //     //   },
  //     // );

  //     // print(response.statusCode);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
