
import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/Interests/index.dart';

class MenuDialogWidget extends StatelessWidget {
  Function addinterest;
  List<Interest> InterestList;
  MenuDialogWidget({
    required this.InterestList,
    required this.addinterest,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 200,
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: InterestList.length,
                itemBuilder: (BuildContext, index) => InkWell(
                      onTap: () {
                        addinterest(InterestList[index].name);
                         Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          InterestList[index].name,
                          style: ThemeHelper().TextStyleMethod2(
                            14,
                            context,
                            FontWeight.w600,
                            Palette.Black,
                          ),
                        ),
                      ),
                    ))),
      ),
    );
  }
}
