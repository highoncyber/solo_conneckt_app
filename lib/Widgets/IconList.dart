import 'package:flutter/material.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/profile/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/qrCode/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/setting/index.dart';

List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.chat_rounded,
    Icons.account_circle,
    Icons.collections_rounded,
    Icons.qr_code_scanner
  ];
  List<IconData> unselectedlistOfIcons = [
    Icons.home_rounded,
    Icons.chat_outlined,
    Icons.account_circle_outlined,
    Icons.collections_outlined,
    Icons.qr_code_scanner,
  ];

  
List<IconData> NfclistOfIcons = [
    Icons.account_circle,
    Icons.people_rounded,
    Icons.nfc_rounded,
    // Icons.qr_code_rounded,
    Icons.apps_rounded,
    Icons.settings
  ];
  List<IconData> nfcUnselectedlistOfIcons = [
    Icons.account_circle_outlined,
    Icons.people_outline,
    Icons.nfc_rounded,
    // Icons.qr_code,
    Icons.apps_rounded,
    Icons.settings,
  ];

  
// NavigationScreens(index,context){
//  if (index == 0) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NfcDashbordHome()),
//                 );
//                 } else if (index == 1) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NfcDashbordConnections()),
//                   );
//                 } else if (index == 2) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NfcDashbordShare()),
//                   );
//                 } else if (index == 3) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NfcDashbordApp(type: "PersonalProfile",)),
//                   );
//                 } else if (index == 4) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NfcDashbordSetting()),
//                   );
//               }
              
// }