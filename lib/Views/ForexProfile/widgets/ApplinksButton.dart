import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/Porfolio.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';

class AddLinksButtons extends StatelessWidget {
  String id;
  String profile;
  Function ontap;
  AddLinksButtons({
    required this.id,
    required this.profile,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            ontap();
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryVariant,
                borderRadius: const BorderRadius.all(Radius.circular(35))),
            child: Center(
              child: Text(
                "Add Custom link",
                style: ThemeHelper().TextStyleMethod2(14, context,
                    FontWeight.w500, Theme.of(context).backgroundColor),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Portfolio(
                        isView: false,
                        profile: profile,
                        user_id: id,
                      )),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryVariant,
                borderRadius: const BorderRadius.all(Radius.circular(35))),
            child: Center(
              child: Text(
                "Add Service",
                style: ThemeHelper().TextStyleMethod2(14, context,
                    FontWeight.w500, Theme.of(context).backgroundColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
