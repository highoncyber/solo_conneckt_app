import 'package:flutter/material.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/sorting.dart';

import '../../../../Widgets/IconList.dart';
import 'AddAppPage.dart';

class NfcDashbordApp extends StatelessWidget {
  String type;

  NfcDashbordApp({Key? key, required this.type}) : super(key: key);

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
              Navigator.pop(context, "refresh");
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                //  _ExchangeModalBottomSheet(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAppPage(
                            icon: "default.png",
                            label: "Add link or Text",
                            title: "Custom Link",
                            type: type,
                          )),
                );
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Social Media",
                    style: ThemeHelper().TextStyleMethod2(
                        20,
                        context,
                        FontWeight.w500,
                        Theme.of(context).colorScheme.primaryVariant),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sorting(profile: type,)),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryVariant)),
                      child: Text(
                        "Drag / Sort",
                        style: ThemeHelper().TextStyleMethod2(
                            14,
                            context,
                            FontWeight.w500,
                            Theme.of(context).colorScheme.primaryVariant),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SocialMediaLinksWidget(
                icon: "instagram.png",
                label: "Instagram Username",
                title: "Instagram",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "facebook.png",
                label: "Facebook Url",
                title: "Facebook",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "mail.png",
                label: "Mail Id",
                title: "Mail",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "phone.png",
                label: "Phone Number",
                title: "Call",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "whatsapp.png",
                label: "WhatsApp Number",
                title: "WhatsApp",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "tiktok.png",
                label: "TikTok Username",
                title: "TikTok",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "twitor.png",
                label: "Twitter Username",
                title: "Twitter",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "youtube.png",
                label: "Youtube Url",
                title: "Youtube",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "snapchat.png",
                label: "Snapchat Username",
                title: "Snapchat",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "telegram.png",
                label: "Telegram Username",
                title: "Telegram",
                type: type,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Business",
                    style: ThemeHelper().TextStyleMethod2(
                        20,
                        context,
                        FontWeight.w500,
                        Theme.of(context).colorScheme.primaryVariant),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SocialMediaLinksWidget(
                icon: "linkdin.png",
                label: "Linkdin Url",
                title: "Linkdin",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "indeed.png",
                label: "Indeed Url",
                title: "Indeed",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "paypal.png",
                label: "Paypal Username",
                title: "Paypal",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "cashapp.png",
                label: "Cashapp Username",
                title: "Cashapp",
                type: type,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Get Inspired",
                    style: ThemeHelper().TextStyleMethod2(
                        20,
                        context,
                        FontWeight.w500,
                        Theme.of(context).colorScheme.primaryVariant),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SocialMediaLinksWidget(
                icon: "venmo.png",
                label: "Venmo Username",
                title: "Venmo",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "pinterest.png",
                label: "Pinterest Url",
                title: "Pinterest",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "Binance.png",
                label: "Behance Url",
                title: "Behance",
                type: type,
              ),
              SocialMediaLinksWidget(
                icon: "dribble.png",
                label: "Dribble Url",
                title: "Dribble",
                type: type,
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Music",
                    style: ThemeHelper().TextStyleMethod2(
                        20,
                        context,
                        FontWeight.w500,
                        Theme.of(context).colorScheme.primaryVariant),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SocialMediaLinksWidget(
                icon: "spotify.png",
                label: "Spotify Url",
                title: "Spotify",
                type: type,
              ),
              // SocialMediaLinksWidget(icon: "assets/images/mail.png",label: "Mail Id",title: "Mail",)
            ]),
          ),
        ),
      ),
    );
  }
}

class SocialMediaLinksWidget extends StatelessWidget {
  String title, icon, label, type;
  bool isSort;
  SocialMediaLinksWidget(
      {Key? key,
      required this.icon,
       this.isSort=false,
      required this.label,
      required this.title,
      required this.type})
      : super(key: key);

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
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              "assets/images/" + icon,
              height: 45,
              width: 45,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: ThemeHelper().TextStyleMethod2(16, context, FontWeight.w500,
                Theme.of(context).backgroundColor),
          ),
          Spacer(),
          isSort==true?Container(): InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddAppPage(
                          icon: icon,
                          label: label,
                          title: title,
                          type: type,
                        )),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                  color: Palette.DarkGolden,
                  borderRadius: const BorderRadius.all(Radius.circular(35))),
              child: Text(
                "+ Add",
                style: ThemeHelper().TextStyleMethod2(
                    12, context, FontWeight.w500, Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
