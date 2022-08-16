import 'package:flutter/material.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/SingleProfile.dart';

class IconWidget extends StatelessWidget {
  String image,title,link;
  IconWidget({
    required this.image,
    required this.title,
    required this.link,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
       redirectlink(title,link);
    },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage("assets/images/" + image), fit: BoxFit.cover)),
      ),
    );
  }
}