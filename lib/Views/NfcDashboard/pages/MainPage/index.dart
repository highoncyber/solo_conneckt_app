import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/profile/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/setting/index.dart';
import 'package:soloconneckt/Views/NfcSettings/index.dart';
import 'package:soloconneckt/Widgets/IconList.dart';

import '../qrCode/index.dart';

class NFCMainPage extends StatefulWidget {
  final String profiletype;
  NFCMainPage({Key? key, required this.profiletype}) : super(key: key);

  @override
  _NFCMainPageState createState() => _NFCMainPageState();
}

class _NFCMainPageState extends State<NFCMainPage> {
  static List<Widget> bottomBarPages = <Widget>[];
  @override
  void initState() {
    bottomBarPages = <Widget>[
      NfcDashbordHome(),
      NfcDashbordConnections(),
      // ProfileSetting(),
      // NfcDashbordShare(),
      NfcDashbordShare(),
      NfcDashbordApp(type: widget.profiletype),
      NfcDashbordSetting()
    ];
    // TODO: implement initState
    super.initState();
  }

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: bottomBarPages.elementAt(currentIndex),
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
              setState(
                () {
                  currentIndex = index;
                },
              );
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
                      ? NfclistOfIcons[index]
                      : nfcUnselectedlistOfIcons[index],
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
}
