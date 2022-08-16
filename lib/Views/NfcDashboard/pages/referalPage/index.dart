import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/referalPage/progresswidget.dart';
import 'package:soloconneckt/Views/VerificationPage/index.dart';
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Services/constants.dart';
import 'BalanceWidget.dart';


class NfcDashboard extends StatefulWidget {
  // String email, password, name, number;
  // File? imageFile;
  NfcDashboard(
      {
      //   this.email = "",
      // this.name = "",
      // this.password = "",
      // this.number = "",
      // this.imageFile,
      key})
      : super(key: key);

  @override
  State<NfcDashboard> createState() => _NfcDashboardState();
}

class _NfcDashboardState extends State<NfcDashboard> {
  String selectedValue = "Select Interest";
  int tabindex = 0;
  bool isloading = true;

  // void getStories() async {
  //   var url = Uri.parse(base_url + ApiUrl.getInterest);
  //   print(url);
  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       data = json.decode(response.body);
  //       isloading = false;
  //     });
  //   } else {
  //     print("eror");
  //   }
  // }
 late List<_ChartData> data;
   TooltipBehavior? _tooltip;
  // TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    // isloading = true;
    // getStories();
    _tooltip = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y sq.km',
        header: '');
      
    // _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/whitelogo.png",
                    ))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SOLO CONNECKT REWARDS",
                        style: ThemeHelper()
                            .TextStyleMethod1(18, context, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 20),
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.all(2),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image:
                                          DecorationImage(image: NetworkImage(
                                              // snapshot.data[index].User_image !=
                                              //       null
                                              //   ? imageUrlUser +
                                              //       snapshot
                                              //           .data[
                                              //               index]
                                              //           .User_image
                                              //   :
                                              defaultUser), fit: BoxFit.cover),
                                      border: Border.all(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          width: 2),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "Hello",
                                        style: ThemeHelper().TextStyleMethod2(
                                            16,
                                            context,
                                            FontWeight.bold,
                                            Theme.of(context).backgroundColor),
                                      ),
                                    ),
                                    Text(
                                      "Joen Deon",
                                      style: ThemeHelper().TextStyleMethod2(
                                          12,
                                          context,
                                          FontWeight.w500,
                                          Theme.of(context).backgroundColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.settings,
                                  color: Theme.of(context).backgroundColor,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BalanceWidget(
                                widgetcolor2: Palette.GreyContainer,
                                name: "Current Balance",
                                textcolour: Colors.white,
                                value: "\$67633"),
                            BalanceWidget(
                                widgetcolor2: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                name: "Withdraw Earning",
                                textcolour: Theme.of(context).backgroundColor,
                                value: "\$67633"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 30,
                  child: DefaultTabController(
                    length: 3,
                    child: TabBar(
                      // indicator: BoxDecoration(color: Colors.grey),
                      indicatorWeight: 4,
                      labelColor: Theme.of(context).colorScheme.primaryVariant,
                      indicatorColor:
                          Theme.of(context).colorScheme.primaryVariant,
                      onTap: (value) {
                        setState(() {
                          tabindex = value;
                        });
                      },
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: "Montserrat"),
                      tabs: [
                        Tab(
                          text: 'Monthly',
                        ),
                        Tab(
                          text: 'Weekly',
                        ),
                        Tab(
                          text: 'Daily',
                        ),
                      ],
                    ),
                  ),
                ),
                SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                trackBorderColor: Colors.black,
                trackColor: Colors.black,
                 dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                   borderRadius:BorderRadius.only(topLeft: Radius.circular(10),topRight:  Radius.circular(10)),// BorderRadius.circular(10),
                  color: Palette.Golden)
            ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Text(
                        "Progress",
                        textAlign: TextAlign.start,
                        style: ThemeHelper().TextStyleMethod2(
                            15,
                            context,
                            FontWeight.w600,
                            Theme.of(context).colorScheme.primaryVariant),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProgressWidget(
                        widgetcolor: Palette.Golden,
                        widgetcolor2: Palette.lightGolden,
                        textcolour: Colors.black,
                        name: "Total Refferals",
                        value: "12311",
                      ),
                      ProgressWidget(
                        widgetcolor2: Colors.black,
                        widgetcolor: Colors.grey,
                        textcolour: Colors.white,
                        name: "Paid Refferals",
                        value: "12311",
                      ),
                      ProgressWidget(
                        widgetcolor2: Color.fromARGB(255, 206, 205, 205),
                        textcolour: Colors.black,
                        widgetcolor: Colors.grey,
                        name: "Unpaid Refferals",
                        value: "12311",
                      ),
                      ProgressWidget(
                        widgetcolor2: Colors.black,
                        widgetcolor: Colors.grey,
                        textcolour: Colors.white,
                        name: "Total Payout Transactions",
                        value: "12311",
                      ),
                    ],
                  ),
                  
                ),
                SizedBox(height: 20,)
              ],
            ),
          )
              // : Center(child: CircularProgressIndicator()),
              ),
        ));
  }}
  class _ChartData {
  _ChartData(this.x, this.y);
 
  final String x;
  final double y;
}

//   List<ColumnSeries<ChartSampleData, String>> _getRoundedColumnSeries() {
//     return <ColumnSeries<ChartSampleData, String>>[
//       ColumnSeries<ChartSampleData, String>(
//         width: 0.9,
//         dataLabelSettings: const DataLabelSettings(
//             isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
//         dataSource: <ChartSampleData>[
//           ChartSampleData(x: 'New York', y: 8683),
//           ChartSampleData(x: 'Tokyo', y: 6993),
//           ChartSampleData(x: 'Chicago', y: 5498),
//           ChartSampleData(x: 'Atlanta', y: 5083),
//           ChartSampleData(x: 'Boston', y: 4497),
//         ],

//         /// If we set the border radius value for column series,
//         /// then the series will appear as rounder corner.
//         borderRadius: BorderRadius.circular(10),
//         xValueMapper: (ChartSampleData sales, _) => sales.x as String,
//         yValueMapper: (ChartSampleData sales, _) => sales.y,
//       ),
//     ];
//   }
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(IterableProperty<_ChartData>('data', data));
//   }
// }
///Chart sample data
// class ChartSampleData {
//   /// Holds the datapoint values like x, y, etc.,
//   ChartSampleData(
//       {this.x,
//       this.y,
//       this.xValue,
//       this.yValue,
//       this.secondSeriesYValue,
//       this.thirdSeriesYValue,
//       this.pointColor,
//       this.size,
//       this.text,
//       this.open,
//       this.close,
//       this.low,
//       this.high,
//       this.volume});

//   /// Holds x value of the datapoint
//   final dynamic x;

//   /// Holds y value of the datapoint
//   final num? y;

//   /// Holds x value of the datapoint
//   final dynamic xValue;

//   /// Holds y value of the datapoint
//   final num? yValue;

//   /// Holds y value of the datapoint(for 2nd series)
//   final num? secondSeriesYValue;

//   /// Holds y value of the datapoint(for 3nd series)
//   final num? thirdSeriesYValue;

//   /// Holds point color of the datapoint
//   final Color? pointColor;

//   /// Holds size of the datapoint
//   final num? size;

//   /// Holds datalabel/text value mapper of the datapoint
//   final String? text;

//   /// Holds open value of the datapoint
//   final num? open;

//   /// Holds close value of the datapoint
//   final num? close;

//   /// Holds low value of the datapoint
//   final num? low;

//   /// Holds high value of the datapoint
//   final num? high;

//   /// Holds open value of the datapoint
//   final num? volume;
// }
