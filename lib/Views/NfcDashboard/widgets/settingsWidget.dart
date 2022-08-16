
import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';

class SettingListWidget extends StatelessWidget {
  Function ontap;
  String text;
  bool isIconVisible;
  SettingListWidget({
    required this.ontap,
    required this.text,
    this.isIconVisible=true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        ontap();
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        // height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryVariant,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: ThemeHelper().TextStyleMethod2(20, context,
                      FontWeight.w500, Theme.of(context).backgroundColor),
                ),
                isIconVisible? Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Theme.of(context).backgroundColor,
                    ):Container()
              ]),
        ),
      ),
    );
  }
}
