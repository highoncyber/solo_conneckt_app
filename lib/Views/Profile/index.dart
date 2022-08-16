import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/AddTopic/index.dart';
import 'package:soloconneckt/Views/ArtGallery/index.dart';
import 'package:soloconneckt/Views/Chat/index.dart';
import 'package:soloconneckt/Views/CreatePost/index.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/Profile/editProfile.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Views/QrCode/index.dart';
import 'package:soloconneckt/Widgets/IconList.dart';
import 'package:soloconneckt/classes/post.dart';

import '../../Styles/ThemeHelper.dart';
import '../CreateStory/index.dart';
import '../Interests/index.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var currentIndex = 2;
  String usename = "", email = "", image = "", id = "";
  String islogin = "No";
  bool setting = false;
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email")!;
    image = prefs.getString("image")!;
    id = prefs.getString("user_id")!;
    String? islogin = prefs.getString("is_logged_in");
    setState(() {});
    getPost();
    getSavedPost();
  }

  initState() {
    addStringToSF();

    super.initState();
  }

  int tabindex = 0;
  List<Post_item> post = [];
  List<Post_item> post2 = [];
  bool isloading = true;
  bool isloading2 = true;
  getPost() async {
    bool isloading = true;
    var url = Uri.parse(base_url + ApiUrl.getPostById(id, true));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        Post_item item = Post_item(
            d["post_id"],
            "",
            d["post_image"],
            d["datetime"],
            d["caption"],
            d["User_image"],
            "",
            d["user_name"],
            d["false"],
            d["false"]);
        // ignore: invalid_use_of_protected_member
        post.add(item);
        // print(users[0].date);
      }

    print(post.length);
    isloading = false;
    setState(() {});
  }

  getSavedPost() async {
    bool isloading2 = true;
    var url = Uri.parse(base_url + ApiUrl.getSavedPost(id));
    print(url);
    print("idd " + id);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(response.body);
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        Post_item item = Post_item(d["post_id"], "", d["post_image"],
            d["datetime"], d["caption"], "", "", "", d["isLiked"], d["true"]);
        // ignore: invalid_use_of_protected_member
        post2.add(item);
        // print(users[0].date);
      }

    print(post2.length);
    isloading2 = false;
    setState(() {});
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile",
                  style: ThemeHelper()
                      .TextStyleMethod1(18, context, FontWeight.w600),
                ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.edit,
                //       color: Colors.blue,
                //     ),
                //     InkWell(
                //       onTap: () async {
                //         final RouteResponse = await Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => EditProfile()),
                //         );
                //         if (RouteResponse == "refresh") {
                //           addStringToSF();
                //         }
                //       },
                //       child: Text(
                //         "Edit",
                //         style: ThemeHelper().TextStyleMethod2(
                //             14, context, FontWeight.normal, Colors.blue),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 11,
              child: SingleChildScrollView(
                child: Container(
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(image != null
                                        ? imageUrlUser + image
                                        : defaultUser),
                                    fit: BoxFit.cover),
                              ),
                              height: 150,
                              // child: ,
                            ),
                            Container(
                              height: 200,
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(image != null
                                              ? imageUrlUser + image
                                              : defaultUser),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (setting)
                                      setting = false;
                                    else
                                      setting = true;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              usename,
                              style: ThemeHelper().TextStyleMethod1(
                                  18, context, FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Designer",
                                  style: ThemeHelper().TextStyleMethod1(
                                      12, context, FontWeight.normal),
                                ),
                                Text(
                                  "@Company E",
                                  style: ThemeHelper().TextStyleMethod2(12,
                                      context, FontWeight.normal, Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      post.length == 0 && isloading == false
                          ? AddTopicWidget(id: id)
                          : Container(),
                      SizedBox(
                        height: 15,
                      ),
                      setting
                          ? SettingWidget(
                              addStringToSF: addStringToSF,
                            )
                          : Container(
                              child: Column(children: [
                                Container(
                                  child: DefaultTabController(
                                    length: 2,
                                    child: TabBar(
                                      labelColor: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      indicatorColor: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      indicator: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                      ),
                                      onTap: (value) {
                                        setState(() {
                                          tabindex = value;
                                        });
                                      },
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: "Montserrat"),
                                      tabs: [
                                        Tab(
                                            icon: Icon(
                                          Icons.dashboard,
                                          size: 20,
                                          color: tabindex == 0
                                              ? Theme.of(context)
                                                  .backgroundColor
                                              : Colors.grey,
                                        )),
                                        Tab(
                                          icon: Icon(
                                            Icons.bookmark_border_outlined,
                                             size: 20,
                                            color: tabindex == 1
                                                ? Theme.of(context)
                                                    .backgroundColor
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                tabindex == 0
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 3,
                                        ),
                                        itemCount: post.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: post[index].post_image !=
                                                      null
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          imageUrlPost +
                                                              post[index]
                                                                  .post_image),
                                                      fit: BoxFit.cover)
                                                  : null,
                                            ),
                                          );
                                        })
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 3,
                                        ),
                                        itemCount: post2.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: post2[index].post_image !=
                                                      null
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          imageUrlPost +
                                                              post2[index]
                                                                  .post_image),
                                                      fit: BoxFit.cover)
                                                  : null,
                                            ),
                                          );
                                        }),
                              ]),
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 8),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          // borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .005),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsFeed()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat()),
                );
              }
              //  else if (index == 2) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Profile()),
              //   );
              // }
              else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArtGallery()),
                );
              } else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCode()),
                );
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .032,
                    left: size.width * .032,
                  ),
                  width: size.width * .128,
                  height: index == currentIndex ? size.width * .012 : 0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                Icon(
                  index == currentIndex
                      ? listOfIcons[index]
                      : unselectedlistOfIcons[index],
                  size: 28,
                  color: index == currentIndex
                      ? Theme.of(context).colorScheme.primaryVariant
                      : Palette.secondaryColor,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddTopicWidget extends StatelessWidget {
  const AddTopicWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryVariant,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Text(
            "You haven’t posted anything",
            style: ThemeHelper().TextStyleMethod2(16, context, FontWeight.w500,
                Theme.of(context).backgroundColor),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AddTopic(
                    //             id: id,
                    //           )),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatePost()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).backgroundColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Text(
                          "Add Posts",
                          style: ThemeHelper().TextStyleMethod2(
                              12, context, FontWeight.w500, Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  SettingWidget({
    this.addStringToSF,
    Key? key,
  }) : super(key: key);
  Function? addStringToSF;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       width: 20,
        //     ),
        //     InkWell(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const CreatePost()),
        //         );
        //       },
        //       child: Text(
        //         "Add Post",
        //         style: ThemeHelper().TextStyleMethod2(
        //             14, context, FontWeight.normal, Colors.blue),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 15,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       width: 20,
        //     ),
        //     InkWell(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const CreateStory()),
        //         );
        //       },
        //       child: Text(
        //         "Add Story",
        //         style: ThemeHelper().TextStyleMethod2(
        //             14, context, FontWeight.normal, Colors.blue),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 4.0),
              child: Text(
                "Account settings",
                style: ThemeHelper()
                    .TextStyleMethod1(16, context, FontWeight.w600),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: () async {
              final RouteResponse = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
              if (RouteResponse == "refresh") {
                addStringToSF!();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.account_circle,
                    size: 45,
                    color: Palette.secondaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your profile",
                        style: ThemeHelper()
                            .TextStyleMethod1(14, context, FontWeight.w600),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Edit and view profile info",
                        style: ThemeHelper()
                            .TextStyleMethod1(12, context, FontWeight.normal),
                      ),
                    ],
                  )
                ]),
                Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                  color: Palette.secondaryColor,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Divider(
            color: Palette.secondaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Interests(
                          isEdit: true,
                        )),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 45,
                    color: Palette.secondaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Interest",
                        style: ThemeHelper()
                            .TextStyleMethod1(14, context, FontWeight.w600),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Edit And View the Interests.",
                        style: ThemeHelper()
                            .TextStyleMethod1(12, context, FontWeight.normal),
                      ),
                    ],
                  )
                ]),
                Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                  color: Palette.secondaryColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
