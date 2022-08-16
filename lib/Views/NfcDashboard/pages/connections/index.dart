import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/ConnectionController.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/AddConnection.dart';
import 'package:soloconneckt/Views/NfcDashboard/widgets/ExchangeWidget.dart';
import 'package:soloconneckt/Views/NfcDashboard/widgets/connectionsWidget.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:http/http.dart' as http;
import '../../../../Services/ApiCalling.dart';
import '../../../../Widgets/IconList.dart';
import '../../../../classes/pesonalProfile.dart/userprofile.dart';

class NfcDashbordConnections extends StatefulWidget {
  NfcDashbordConnections({Key? key})
      : super(key: key);

  @override
  State<NfcDashbordConnections> createState() => _NfcDashbordConnectionsState();
}

class _NfcDashbordConnectionsState extends State<NfcDashbordConnections> {
  int tabindex = 0;
  String id = "";
  ConnectionController pconnectionController = Get.find();

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("user_id")!;
    // String? islogin2 = prefs.getString("is_logged_in");
    setState(() {});
    pconnectionController.getExchangeUser(id);
    pconnectionController.getConnectionUser(id);
  }

  @override
  void initState() {
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }

  onclickExchage( exchangeID) {
    _ExchangeModalBottomSheet(
        context, exchangeID, this.id);
  }

  onclickConnections(connectionid) {
    _ConnectionModalBottomSheet(
        context, connectionid, this.id);
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
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       //  _ExchangeModalBottomSheet(context);
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => AddConnection()),
          //       );
          //     },
          //     icon: Icon(
          //       Icons.add,
          //       color: Theme.of(context).colorScheme.primaryVariant,
          //     ),
          //   ),
          // ]
          ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.primaryVariant,
                  indicatorColor: Palette.DarkGolden,
                  onTap: (value) {
                    pconnectionController.tabindex.value = value;
                  },
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "Montserrat"),
                  tabs: const [
                    Tab(
                      text: 'Connections',
                    ),
                    Tab(
                      text: 'Exchange',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => pconnectionController.tabindex.value == 0
                ? Obx(
                    () => pconnectionController.isloading.value == true
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pconnectionController
                                .Connectionuser_item.length,
                            itemBuilder: (BuildContext, index) =>
                                ConnectionsWidget(
                                  onclickConnection: onclickConnections,
                                  excahngeuser_item:
                                      pconnectionController.Connectionuser_item,
                                  index: index,
                                )),
                  )
                : Obx(
                    () => pconnectionController.isloading2.value == true
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pconnectionController.Exchangeist.length,
                            itemBuilder: (BuildContext, index) =>
                                ExchangeWidget(
                                  onclickExchage: onclickExchage,
                                  excahngeuser_item:
                                      pconnectionController.Exchangeist,
                                  index: index,
                                )),
                  ))
          ]),
        ),
      ),
      // bottomSheet: _showBottomSheet(),
    );
  }
}

void _ExchangeModalBottomSheet(
    context, id, currentId) {
  ConnectionController pconnectionController = Get.find();
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Wrap(
            children: <Widget>[
              ListTile(
                  title: Text(
                    "Move to Connections",
                    style: ThemeHelper().TextStyleMethod2(
                        16, context, FontWeight.w500, Colors.black),
                  ),
                  onTap: () async => {
                         await ApiCall().MoveToConnection( id, context),
                        pconnectionController.getExchangeUser(
                            currentId),
                        pconnectionController.getConnectionUser(
                            currentId)
                      }),
              Divider(color: Colors.black, height: 5),
              ListTile(
                title: Text(
                  'Delete',
                  style: ThemeHelper().TextStyleMethod2(
                      16, context, FontWeight.w500, Colors.red),
                ),
                onTap: () => {
                  ApiCall().DeleteExchange(id, context),
                  Navigator.pop(context),
                  pconnectionController.getExchangeUser(currentId),
                  pconnectionController.getConnectionUser(
                      currentId),
                },
              ),
              Divider(color: Colors.black, height: 5),
              ListTile(
                title: Text(
                  'Cancel',
                  style: ThemeHelper().TextStyleMethod2(
                      16, context, FontWeight.w500, Colors.black),
                ),
                onTap: () => {Navigator.pop(context)},
              ),
            ],
          ),
        );
      });
}

void _ConnectionModalBottomSheet(context, id, currentId) {
  print("exchange id ${id}");
  ConnectionController pconnectionController = Get.find();
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Delete',
                  style: ThemeHelper().TextStyleMethod2(
                      16, context, FontWeight.w500, Colors.red),
                ),
                onTap: () async => {
                   await ApiCall().DeleteConnection(id, context),
                  Navigator.pop(context),
                  pconnectionController.getConnectionUser(
                      currentId),
                        pconnectionController.getExchangeUser(
                      currentId)
                },
              ),
              Divider(color: Colors.black, height: 5),
              ListTile(
                title: Text(
                  'Cancel',
                  style: ThemeHelper().TextStyleMethod2(
                      16, context, FontWeight.w500, Colors.blue),
                ),
                onTap: () => {Navigator.pop(context)},
              ),
            ],
          ),
        );
      });
}
