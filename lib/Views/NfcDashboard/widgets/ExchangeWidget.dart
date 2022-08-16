import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soloconneckt/Controllers/ConnectionController.dart';
import 'package:soloconneckt/Controllers/NewsFeedController.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/profile.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/SingleProfile.dart';
import 'package:soloconneckt/Views/RealEstateProfile/RealEstateProfile/profile.dart';
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';

import '../../../Services/constants.dart';

class ExchangeWidget extends StatelessWidget {
  // var userid;
  int index;
  List<ExchangeUser> excahngeuser_item = [];
  Function onclickExchage;
  ExchangeWidget({
    required this.onclickExchage,
    required this.index,
    required this.excahngeuser_item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsFeedController controller = Get.find();
    return InkWell(
      onTap: () {
        if (controller.forexProfile.value == true)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForexProfileWidget(
                  exchangeid: excahngeuser_item[index].id,
                      id: excahngeuser_item[index].exchangeId,
                    )),
          );
        else if (controller.realEstateProfile.value == true)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RealProfileWidget(
                   exchangeid: excahngeuser_item[index].id,
                      id: excahngeuser_item[index].exchangeId,
                    )),
          );
        else
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NfcDashboardProfile(
                      userid: excahngeuser_item[index].exchangeId,
                    )),
          );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(excahngeuser_item[index].image != null
                      ? imageUrlUser + excahngeuser_item[index].image
                      : defaultUser),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                excahngeuser_item[index].user_name,
                style: ThemeHelper().TextStyleMethod2(
                    18,
                    context,
                    FontWeight.w600,
                    Theme.of(context).colorScheme.primaryVariant),
              ),
              Text(
                "Digital Bussiness Card",
                style: ThemeHelper().TextStyleMethod2(
                    14,
                    context,
                    FontWeight.normal,
                    Theme.of(context).colorScheme.primaryVariant),
              ),
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                onclickExchage(
                    excahngeuser_item[index].id);
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).colorScheme.primaryVariant,
              ))
        ]),
      ),
    );
  }
}
