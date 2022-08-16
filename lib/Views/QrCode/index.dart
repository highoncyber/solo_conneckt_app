import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/webViewPage/index.dart';
import 'package:soloconneckt/Views/ArtGallery/index.dart';
import 'package:soloconneckt/Views/Chat/index.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/Profile/index.dart';
import 'package:soloconneckt/Widgets/IconList.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  var currentIndex = 4;
  Barcode? result;
  bool gotValidQR = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
                          await controller?.resumeCamera();
                        },
                        icon: Icon(Icons.center_focus_strong,
                            color: Theme.of(context)
                                .colorScheme
                                .primaryVariant)),
                    Text(
                      "Scan profile",
                      style: ThemeHelper().TextStyleMethod2(
                          18,
                          context,
                          FontWeight.w500,
                          Theme.of(context).colorScheme.primaryVariant),
                    ),
                    IconButton(
                        onPressed: () async {
                           setState(() {
                            gotValidQR=false;
                          });
                          await controller?.toggleFlash();
                          
                        },
                        icon: Icon(Icons.flash_auto_outlined,
                            color:Theme.of(context).colorScheme.primaryVariant)),
                    // Container(
                    //   margin: const EdgeInsets.all(8),
                    //   child: ElevatedButton(
                    //       onPressed: () async {
                    //         await controller?.toggleFlash();
                    //         setState(() {});
                    //       },
                    //       child: FutureBuilder(
                    //         future: controller?.getFlashStatus(),
                    //         builder: (context, snapshot) {
                    //           return Text('Flash: ${snapshot.data}');
                    //         },
                    //       )),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.all(8),
                    //   child: ElevatedButton(
                    //       onPressed: () async {
                    //         await controller?.flipCamera();
                    //         setState(() {});
                    //       },
                    //       child: FutureBuilder(
                    //         future: controller?.getCameraInfo(),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.data != null) {
                    //             return Text(
                    //                 'Camera facing ${describeEnum(snapshot.data!)}');
                    //           } else {
                    //             return const Text('loading');
                    //           }
                    //         },
                    //       )),
                    // )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     Container(
                //       margin: const EdgeInsets.all(8),
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           await controller?.pauseCamera();
                //         },
                //         child: const Text('pause',
                //             style: TextStyle(fontSize: 20)),
                //       ),
                //     ),
                //     Container(
                //       margin: const EdgeInsets.all(8),
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           await controller?.resumeCamera();
                //         },
                //         child: const Text('resume',
                //             style: TextStyle(fontSize: 20)),
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          Expanded(flex: 5, child: _buildQrView(context)),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 8),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          // borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .005),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsFeed()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArtGallery()),
                );
              }
              //  else if (index == 4) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => QRCode()),
              //   );
              // }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .032,
                    left: size.width * .032,
                  ),
                  width: size.width * .128,
                  height: index == currentIndex ? size.width * .012 : 0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                Icon(
                  index == currentIndex
                      ? listOfIcons[index]
                      : unselectedlistOfIcons[index],
                  size: 28,
                  color: index == currentIndex
                      ? Theme.of(context).colorScheme.primaryVariant
                      : Palette.secondaryColor,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 600 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
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
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if(gotValidQR) {
        controller.pauseCamera();
      return;
    }
        
         var url = result!.code.toString();

              // ignore: deprecated_member_use
              if (await canLaunch(url)) {
                await launch(
                  url,
                  universalLinksOnly: true,
                );
              } else {
                throw 'There was a problem to open the url: $url';
              }
            
            setState(() {
              gotValidQR=true;
            });
        
      
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

// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:soloconneckt/Styles/ThemeHelper.dart';
// import 'package:soloconneckt/Styles/palette.dart';
// import 'package:soloconneckt/Views/ArtGallery/index.dart';
// import 'package:soloconneckt/Views/Chat/index.dart';
// import 'package:soloconneckt/Views/NewsFeed/index.dart';
// import 'package:soloconneckt/Views/Profile/index.dart';
// import 'package:soloconneckt/Widgets/IconList.dart';
// import 'package:soloconneckt/Widgets/ShowResponse.dart';

// class QRCode extends StatefulWidget {
//   const QRCode({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRCodeState();
// }

// class _QRCodeState extends State<QRCode> {
//    var currentIndex = 4;
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var status = controller?.getFlashStatus();
//     print("flash status");
    
//   Size size = MediaQuery.of(context).size;
//     print(status);
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primaryVariant,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).backgroundColor,
//         centerTitle: true,
//         title:  Text(
//             "SOLO CONNECKT",
//             style: ThemeHelper().TextStyleMethod2(20, context, FontWeight.w600,Theme.of(context).colorScheme.primaryVariant),
//           ),
//       leading:IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon:  Icon(
//               Icons.arrow_back_rounded,
//               color: Theme.of(context).colorScheme.primaryVariant,
//             ),
//           ),),
//       body: SafeArea(
//         child: Stack(
//           children: <Widget>[
//             _buildQrView(context),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                       onPressed: () async {
//                         await controller?.resumeCamera();
//                       },
//                       icon: Icon(Icons.center_focus_strong,
//                           color: Theme.of(context).backgroundColor)),
//                   Text(
//                     "Scan profile",
//                     style: ThemeHelper().TextStyleMethod2(18, context,
//                         FontWeight.w600, Theme.of(context).backgroundColor),
//                   ),
//                   // Container(
//                   //   margin: const EdgeInsets.all(8),
//                   //   child: ElevatedButton(
//                   //       onPressed: () async {
//                   //         await controller?.flipCamera();
//                   //         setState(() {});
//                   //       },
//                   //       child: FutureBuilder(
//                   //         future: controller?.getCameraInfo(),
//                   //         builder: (context, snapshot) {
//                   //           if (snapshot.data != null) {
//                   //             return Text(
//                   //                 'Camera facing ${describeEnum(snapshot.data!)}');
//                   //           } else {
//                   //             return const Text('loading');
//                   //           }
//                   //         },
//                   //       )),
//                   // ),
//                   // InkWell(
//                   //   onTap: () async {
//                   //      await controller?.toggleFlash();
//                   //           setState(() {});
//                   //   },
//                   //   child: FutureBuilder(
//                   //     future: controller?.getFlashStatus(),
//                   //     builder: (context) {
//                   //       return Icon(Icons.flash_auto_outlined,color: Theme.of(context).backgroundColor);
//                   //     }
//                   //   )),
//                   IconButton(
//                       onPressed: () async {
//                         await controller?.toggleFlash();
//                         setState(() {});
//                       },
//                       icon: Icon(Icons.flash_auto_outlined,
//                           color: Theme.of(context).backgroundColor)),
//                 ],
//               ),
//             ),
//             // FittedBox(
//             //   fit: BoxFit.contain,
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //     children: <Widget>[
//             //       if (result != null)
//             //         Text(
//             //             'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//             //       else
//             //         const Text('Scan a code'),
//             //       Row(
//             //         mainAxisAlignment: MainAxisAlignment.center,
//             //         crossAxisAlignment: CrossAxisAlignment.center,
//             //         children: <Widget>[
//             //           Container(
//             //             margin: const EdgeInsets.all(8),
//             //             child: ElevatedButton(
//             //                 onPressed: () async {
//             //                   await controller?.toggleFlash();
//             //                   setState(() {});
//             //                 },
//             //                 child: FutureBuilder(
//             //                   future: controller?.getFlashStatus(),
//             //                   builder: (context, snapshot) {
//             //                     return Text('Flash: ${snapshot.data}');
//             //                   },
//             //                 )),
//             //           ),
//             //           Container(
//             //             margin: const EdgeInsets.all(8),
//             //             child: ElevatedButton(
//             //                 onPressed: () async {
//             //                   await controller?.flipCamera();
//             //                   setState(() {});
//             //                 },
//             //                 child: FutureBuilder(
//             //                   future: controller?.getCameraInfo(),
//             //                   builder: (context, snapshot) {
//             //                     if (snapshot.data != null) {
//             //                       return Text(
//             //                           'Camera facing ${describeEnum(snapshot.data!)}');
//             //                     } else {
//             //                       return const Text('loading');
//             //                     }
//             //                   },
//             //                 )),
//             //           )
//             //         ],
//             //       ),
//             //       Row(
//             //         mainAxisAlignment: MainAxisAlignment.center,
//             //         crossAxisAlignment: CrossAxisAlignment.center,
//             //         children: <Widget>[
//             //           Container(
//             //             margin: const EdgeInsets.all(8),
//             //             child: ElevatedButton(
//             //               onPressed: () async {
//             //                 await controller?.pauseCamera();
//             //               },
//             //               child: const Text('pause',
//             //                   style: TextStyle(fontSize: 20)),
//             //             ),
//             //           ),
//             //           Container(
//             //             margin: const EdgeInsets.all(8),
//             //             child: ElevatedButton(
//             //               onPressed: () async {
//             //                 await controller?.resumeCamera();
//             //               },
//             //               child: const Text('resume',
//             //                   style: TextStyle(fontSize: 20)),
//             //             ),
//             //           )
//             //         ],
//             //       ),
//             //     ],
//             //   ),
//             // )
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.only(left: 8),
//         height: size.width * .155,
//         decoration: BoxDecoration(
//           color: Theme.of(context).backgroundColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.15),
//               blurRadius: 30,
//               offset: Offset(0, 10),
//             ),
//           ],
//           // borderRadius: BorderRadius.circular(50),
//         ),
//         child: ListView.builder(
//           itemCount: 5,
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.symmetric(horizontal: size.width * .005),
//           itemBuilder: (context, index) => InkWell(
//             onTap: () {
//               if(index==0){
//                  Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  NewsFeed()),
//               );
//               }
//               else if(index==1){
//                  Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  Chat()),
//               );
//               }
//               else if(index==2){
//                  Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  Profile()),
//               );
//               }
//               else if(index==3){
//                  Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  ArtGallery()),
//               );
//               }
//               else if(index==4){
//                  Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  QRCode()),
//               );
//               }
//             },
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 AnimatedContainer(
//                   duration: Duration(milliseconds: 1500),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   margin: EdgeInsets.only(
//                     bottom: index == currentIndex ? 0 : size.width * .029,
//                     right: size.width * .032,
//                     left: size.width * .032,
//                   ),
//                   width: size.width * .128,
//                   height: index == currentIndex ? size.width * .012 : 0,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primaryVariant,
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                 ),
//                 Icon(
//                   index == currentIndex
//                       ? listOfIcons[index]
//                       : unselectedlistOfIcons[index],
//                   size: 28,
//                   color: index == currentIndex
//                       ? Theme.of(context).colorScheme.primaryVariant
//                       : Palette.secondaryColor,
//                 ),
//                 SizedBox(height: size.width * .03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Theme.of(context).backgroundColor,
//           // borderRadius: 10,
//           borderLength: 50,
//           borderWidth: 6,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text('no Permission')),
//       // );
//       ShowResponse("Permission required to scan", context);
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
