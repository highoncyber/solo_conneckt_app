import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/index.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/profile.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/SingleProfile.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Views/RealEstateProfile/RealEstateProfile/profile.dart';

class ProductActivation extends StatefulWidget {
  const ProductActivation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductActivationState();
}

class _ProductActivationState extends State<ProductActivation> {
  var currentIndex = 4;
  bool gotValidQR = false;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          "SOLO CONNECKT",
          style: ThemeHelper().TextStyleMethod2(20, context, FontWeight.w600,
              Theme.of(context).colorScheme.primaryVariant),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // if (result != null)
                //   Text(
                //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                // else
                //   const Text('Scan a code'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            gotValidQR = false;
                          });
                          await controller?.resumeCamera();
                        },
                        icon: Icon(Icons.center_focus_strong,
                            color:
                                Theme.of(context).colorScheme.primaryVariant)),
                    Text(
                      "Solo Card",
                      style: ThemeHelper().TextStyleMethod2(
                          18,
                          context,
                          FontWeight.w500,
                          Theme.of(context).colorScheme.primaryVariant),
                    ),
                    IconButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        icon: Icon(Icons.flash_auto_outlined,
                            color:
                                Theme.of(context).colorScheme.primaryVariant)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 5, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 600 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // print("Safeareeaaa");
    // print(scanArea);
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          // borderRadius: 10,
          borderLength: 100,
          borderWidth: 5,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    String userId = "", activeProfile = "";
    var JsonData;
    getUserID(serial) async {
      var url = Uri.parse(base_url + ApiUrl.getUserId(serial));
      print(url);
      // print("idd " + id);
      var response = await http.get(url);
      JsonData = json.decode(response.body);
      print(response.body);
      if (JsonData[0]["code"] != 0) {
        userId = JsonData[0]["user_id"];
        activeProfile = JsonData[0]["ActiveProfile"];
      }
      setState(() {});
    }

    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      // print(scanData);
      if (gotValidQR) {
        controller.pauseCamera();
        return;
      }
      setState(() {
        result = scanData;
          gotValidQR = true;
      });
      var url = result!.code.toString();
      List splittedText = url.split('=');
      String serialNo = splittedText[1];
      // print(serialNo);
      //   setState(() {
      //   gotValidQR = true;
      // });

      await getUserID(serialNo);
      if(activeProfile=="1"){
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForexProfileWidget(
              id: userId,

                )),
      );
      }else if(activeProfile=="2"){
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RealProfileWidget(
              id: userId,

                )),
      );
      }
      else{
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NfcDashboardProfile(
                  userid: "",
                  serial: serialNo,
                )),
      );}
    
      // // ignore: deprecated_member_use
      // if (await canLaunch(url)) {
      //   await launch(
      //     url,
      //     universalLinksOnly: true,
      //   );
      // } else {
      //   throw 'There was a problem to open the url: $url';
      // }

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => InAppWebViewExampleScreen(
      //             url: result!.code.toString(),
      //           )),
      // );
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
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
