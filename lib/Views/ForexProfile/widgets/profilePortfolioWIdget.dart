
import 'package:flutter/material.dart';
import 'package:perspective_pageview/perspective_pageview.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/classes/post.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({
    Key? key,
    required this.length,
    required this.portfolio,
  }) : super(key: key);

  final int length;
  final List<Portfolio_item> portfolio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PerspectivePageView(
        hasShadow: true, // Enable-Disable Shadow
        shadowColor: Colors.black12, // Change Color
        aspectRatio:
            PVAspectRatio.ONE_ONE, // Aspect Ratio of 1:1 (Default)
        children: <Widget>[
          for (int i = 0; i < length; i++)
            Image.network(
              imageUrlPortfolio + portfolio[i].file,
              height: 200,
              fit: BoxFit.fill,
            )
          // GestureDetector(
          //   onTap: () {
          //     debugPrint("Statement One");
          //   },
          //   child: Container(
          //     color: Colors.red,
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     debugPrint("Statement Two");
          //   },
          //   child: Container(
          //     color: Colors.green,
          //   ),
          // )
        ],
      ),
    );
  }
}