import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../colors.dart';


class ScanScreen extends StatefulWidget {
  static const routeName = '/ScanScreen';
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.


 Future<void> handleScan(String eventId) async {
  // Récupérer le document correspondant dans la collection "evenement"
  DocumentSnapshot eventSnapshot = await FirebaseFirestore.instance.collection('evenement').doc(eventId).get();
  if (eventSnapshot.exists) {
    // Vérifier si l'événement est valide
    bool isValid = eventSnapshot['isValid'];
    if (isValid) {
      // Mettre à jour le champ "isValid" à false pour indiquer que le billet a été scanné
      await eventSnapshot.reference.update({'isValid': false});
      // Afficher un message pour indiquer que le billet est valide
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Billet valide')));
    } else {
      // Afficher un message pour indiquer que le billet a déjà été scanné
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Billet déjà scanné')));
    }
  } else {
    // Afficher un message pour indiquer que l'ID scanné est invalide
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ID invalide')));
  }
}



  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? //Text( 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  TextButton(onPressed: () => handleScan('${result!.code}'), child: Text('${result!.code}'))
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }


 Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorApp.secondaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    ('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}