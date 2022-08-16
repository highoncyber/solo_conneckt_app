
import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';

class BalanceWidget extends StatelessWidget {
  BalanceWidget({
    required this.widgetcolor2,
    required this.textcolour,
    required this.name,
    required this.value,
    Key? key,
  }) : super(key: key);
  Color widgetcolor2, textcolour;
  String value, name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: widgetcolor2, // Palette.GreyContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: ThemeHelper()
                .TextStyleMethod2(16, context, FontWeight.w600, textcolour),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: ThemeHelper()
                .TextStyleMethod2(16, context, FontWeight.bold, textcolour),
          ),
        ],
      ),
    );
  }
}
