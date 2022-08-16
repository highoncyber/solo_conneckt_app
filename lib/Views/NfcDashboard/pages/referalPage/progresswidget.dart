
import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';

class ProgressWidget extends StatelessWidget {
  ProgressWidget({
    required this.widgetcolor,
    required this.widgetcolor2,
    required this.textcolour,
    required this.name,
    required this.value,
    Key? key,
  }) : super(key: key);
  Color widgetcolor;
  Color widgetcolor2, textcolour;
  String value, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 160,
      height: 140,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // stops: [
            //   0.1,
            //   0.6,],
            colors: [
              widgetcolor2,
              widgetcolor,
            ],
          ),
          // color: widgetcolor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: ThemeHelper()
                  .TextStyleMethod2(16, context, FontWeight.w600, textcolour),
            ),
            Text(
              "\$" + value,
              textAlign: TextAlign.center,
              style: ThemeHelper()
                  .TextStyleMethod2(16, context, FontWeight.bold, textcolour),
            ),
          ]),
    );
  }
}
