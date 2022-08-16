
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';

import '../../../classes/pesonalProfile.dart/userprofile.dart';

class AppLinksWidget extends StatefulWidget {
  String profile;
  int index;
  List<PerosnalProfile_item> profile_item;
  bool isactive;
  AppLinksWidget(
      {Key? key,
      required this.profile,
      required this.isactive,
      required this.index,
      required this.profile_item})
      : super(key: key);

  @override
  State<AppLinksWidget> createState() => _AppLinksWidgetState();
}

class _AppLinksWidgetState extends State<AppLinksWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      // height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryVariant,
          borderRadius: const BorderRadius.all(Radius.circular(35))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
             Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  "assets/images/" +
                      widget.profile_item[widget.index].icon.toString(),
                  height: 45,
                  width: 45,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.profile_item[widget.index].title,
                style: ThemeHelper().TextStyleMethod2(16, context,
                    FontWeight.w500, Theme.of(context).backgroundColor),
              ),
            ]),
            FlutterSwitch(
              width: 43,
              height: 25,
              showOnOff: false,
              activeColor: Palette.DarkGolden,
              inactiveColor: Theme.of(context).backgroundColor,
              activeToggleColor: Theme.of(context).colorScheme.primaryVariant,
              toggleColor: Theme.of(context).colorScheme.primaryVariant,
              value: widget.isactive,
              onToggle: (val) {
                setState(() {
                  widget.isactive = val;
                });
                String active = val ? "1" : "0";
                HttpService().UpdateActiveInactiveStatus(
                    widget.profile_item[widget.index].id,
                    active,
                    widget.profile,
                    context,
                    ApiUrl.updateActiveStatus);
              },
            ),
          ],
        ),
      ),
    );
  }
}
