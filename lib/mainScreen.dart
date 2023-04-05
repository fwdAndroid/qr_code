import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_code/found.dart';
import 'package:qr_code/resultpage.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? result;
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/splash.png"),
            ElevatedButton(
              onPressed: () async {
                _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                    context: context,
                    onCode: (code) {
                      setState(() {
                        this.result = "https://forvilcosmetic.com";
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Found(
                                    result: result!,
                                  )));
                    });
              },
              child: Text(
                "Open Forvil Cosmetics  Scanner",
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Text('Barcode Result: $result'),
          ],
        ),
      ),
    );
  }
}
