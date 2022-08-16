import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soloconneckt/Controllers/ConnectionController.dart';
import 'package:soloconneckt/Services/ApiCalling.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Views/ForexProfile/pages/AddPortfolio.dart';
import 'package:soloconneckt/classes/post.dart';

class Portfolio extends StatefulWidget {
  bool isView;
  String user_id;
  String profile;
  Portfolio({Key? key, required this.user_id, required this.isView, required this.profile})
      : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  // List<Portfolio_item> portfolio = [];
  // bool isloading = true;

  // getPortfolio() async {
  //   var url = Uri.parse(
  //       base_url + ApiUrl.getPortfolio(widget.user_id, widget.profile));
  //   print(url);
  //   var response = await http.get(url);
  //   var JsonData = json.decode(response.body);
  //   print(JsonData[0]["code"]);
  //   if (JsonData[0]["code"] != 0)
  //     // ignore: curly_braces_in_flow_control_structures
  //     for (var d in JsonData) {
  //       Portfolio_item item = Portfolio_item(
  //           d["portfolio_id"], d["profile_type"], d["user_id"], d["file"]);
  //       // ignore: invalid_use_of_protected_member
  //       portfolio.add(item);
  //       // print(users[0].date);
  //     }

  //   print(portfolio.length);
  //   isloading = false;
  //   setState(() {});
  // }

  var currentIndex = 3;
  ConnectionController _controller = Get.find();
  @override
  void initState() {
    _controller.getPortfolio(widget.user_id, widget.profile);
    // TODO: implement initState
    super.initState();
  }

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
        leading:IconButton(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Portfolio",
                      style: ThemeHelper()
                          .TextStyleMethod1(18, context, FontWeight.w600),
                    ),
                    widget.isView?Container(): IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePorfolio(
                                    profile: widget.profile,
                                    // userid: id,
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => _controller.isloading3 == false
                    ? _controller.portfolio.length < 1
                        ? Center(
                            child: Text(
                              "Your Portfolio will show here.",
                              style: ThemeHelper().TextStyleMethod1(
                                  15, context, FontWeight.w500),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _controller.portfolio.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 4,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                    image: _controller.portfolio[index].file !=
                                            null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                imageUrlPortfolio +
                                                    _controller
                                                        .portfolio[index].file),
                                            fit: BoxFit.cover)
                                        : null,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            // print(portfolio[index].portfolio_id);
                                            ApiCall().DeletePorfolio(
                                                _controller.portfolio[index]
                                                    .portfolio_id,
                                                context);
                                            _controller.getPortfolio(
                                                widget.user_id, widget.profile);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                          ))
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          )
                    : CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
