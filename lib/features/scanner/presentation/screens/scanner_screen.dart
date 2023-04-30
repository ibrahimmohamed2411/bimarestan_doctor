import 'dart:io';

import 'package:bimarestan_doctors/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 462.h,
              child: Stack(
                children: [
                  buildQrView(context),
                  Positioned(
                    bottom: 36.h,
                    left: context.width * 0.33,
                    child: Text(
                      'Scanning Code',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).colorScheme.primary,
        borderWidth: 7.w,
        borderLength: 40,
        cutOutWidth: MediaQuery.of(context).size.width * 0.85,
        cutOutHeight: 400.h,
      ),
    );
  }

  Widget buildResult() {
    return Text('Result');
  }

  void onQRViewCreated(QRViewController QRcontroller) {
    controller = QRcontroller;
    QRcontroller.resumeCamera();
    QRcontroller.scannedDataStream.listen((barcode) {
      QRcontroller.pauseCamera();
      //TODO: handle barcode data

      QRcontroller.resumeCamera();
    });
  }
}
