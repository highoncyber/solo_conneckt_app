import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/NewsFeedController.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/ArtGallery/index.dart';
import 'package:soloconneckt/Views/Chat/index.dart';
import 'package:soloconneckt/Views/CreatePost/index.dart';
import 'package:soloconneckt/Views/CreateStory/index.dart';
import 'package:soloconneckt/Views/NewsFeed/SearchNfc.dart';
import 'package:soloconneckt/Views/Profile/index.dart';
import 'package:soloconneckt/Views/QrCode/index.dart';
import 'package:soloconneckt/Views/ViewProfile/index.dart';
import 'package:soloconneckt/Widgets/IconList.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/classes/post.dart';
import 'package:soloconneckt/classes/story.dart';
// import 'package:stories_for_flutter/stories_for_flutter.dart';

import '../../Services/ApiCalling.dart';
import '../../Services/constants.dart';
import '../../Widgets/Navbar.dart';
import 'AppBarNewsFeed.dart';
import 'Stories.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final captionController = new TextEditingController();
  bool isloading = true;
  var currentIndex = 0;

  String usename = "", email = "", image = "";
  String id = "0", interest = "";
  bool islogin = false;
  int indexVal = 0;
  final todaysDate = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("first_name"));
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email")!;
    image = prefs.getString("image")!;
    interest = prefs.getString("interest")!;
    id = prefs.getString("user_id")!;
    // String? islogin2 = prefs.getString("is_logged_in");
    setState(() {});
  }

  Future<List<story>> getStories() async {
    var url = Uri.parse(base_url + ApiUrl.getStory(id));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);
    List<story> storyitem = [];
    int i = 0;
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        i++;
        story item =
            story(d["image"], d["user_name"], d["post_image"], d["user_id"], "",""
                // d["post_image"],
                // d["datetime"],
                // d["caption"],
                // d["User_image"],
                // d["isreport"],
                // d["user_name"],
                // d["isLiked"],
                // d["isSaved"]
                );

        // ignore: invalid_use_of_protected_member
        storyitem.add(item);
      }
    for (int i = 0; i < storyitem.length; i++) {
      // print("idd ${id}");
      if (storyitem[i].user_id == id) {
        indexVal = i;
        // print("idd index ${indexVal}");
      }
    }
    return storyitem;
  }

  Future<List<Post_item>> getPost() async {
    var url = Uri.parse(base_url + ApiUrl.getPostByInterest("true", id));
    var response = await http.get(url);
    print(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);
    List<Post_item> post = [];
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        Post_item item = Post_item(
            d["post_id"],
            d["user_id"],
            d["post_image"],
            d["datetime"],
            d["caption"],
            d["User_image"],
            d["isreport"],
            d["user_name"],
            d["isLiked"],
            d["isSaved"]);
        // ignore: invalid_use_of_protected_member
        post.add(item);
      }
      // post.forEach((element) => print(element.post_image),);
      // print(post.length);
    return post;
  }

  @override
  void initState() {
    // getPost();
    addStringToSF();
    // getStories();
    // TODO: implement initState
    super.initState();
  }

  NewsFeedController newsFeedController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                newsFeedController.isDrawerOpen.value = false;
              },
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: AppBarNewsFeed(
                          newsFeedController: newsFeedController)),
                  Expanded(
                    flex: 10,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 200,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder<List<story>>(
                                  future: getStories(),
                                  builder: ((BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.data == null) {
                                      return Container(
                                          // child: Center(
                                          //     child: CircularProgressIndicator(
                                          //         color: Colors.blue)),
                                          );
                                    } else if (snapshot.data.length == 0) {
                                      return Container(
                                        child: Center(
                                          child: Text(
                                            "Your Recent Story Will Show here...",
                                            style: ThemeHelper()
                                                .TextStyleMethod1(16, context,
                                                    FontWeight.w600),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateStory()),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 200,
                                                    margin: EdgeInsets.only(
                                                        top: 30),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // margin: EdgeInsets.all(2),
                                                          height: 65,
                                                          width: 65,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(image !=
                                                                          ""
                                                                      ? imageUrlUser +
                                                                          image
                                                                      : defaultUser),
                                                                  fit: BoxFit
                                                                      .cover),
                                                              shape: BoxShape
                                                                  .circle),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "+ Add",
                                                          style: ThemeHelper()
                                                              .TextStyleMethod1(
                                                                  12,
                                                                  context,
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                              itemCount: snapshot.data.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext,
                                                      index) =>
                                                  // snapshot.data[index].user_id !=
                                                  //         id
                                                  //     ?
                                                  StatusCircleWidget(
                                                    user_name: snapshot
                                                        .data[index].user_name,
                                                    image: snapshot
                                                        .data[index].image,
                                                    index: index,
                                                    user_id: snapshot
                                                        .data[index].user_id,
                                                    postimage: snapshot
                                                        .data[index].post_image,
                                                  )),
                                        ],
                                      );
                                    }
                                  }),
                                ),
                              )),
                          WhatsOnYourMind(
                              image: image,
                              captionController: captionController),
                          FutureBuilder<List<Post_item>>(
                            future:id!=0? getPost():null,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant)),
                                );
                              } else if (snapshot.data.length == 0) {
                                return Container(
                                  child: Center(
                                    child: Text(
                                      "Your Recent Post Will Show here...",
                                      style: ThemeHelper().TextStyleMethod1(
                                          16, context, FontWeight.w600),
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    // scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext, index) {
                                      var countTime;
                                      var date = DateTime.parse(
                                          snapshot.data[index].datetime);
                                      if (todaysDate
                                              .difference(date)
                                              .inSeconds <
                                          60) {
                                        countTime = "just now";
                                      } else if (todaysDate
                                              .difference(date)
                                              .inMinutes <
                                          60) {
                                        countTime = todaysDate
                                                .difference(date)
                                                .inMinutes
                                                .toString() +
                                            " mins ago";
                                      } else if (todaysDate
                                              .difference(date)
                                              .inHours <
                                          24) {
                                        countTime = todaysDate
                                                .difference(date)
                                                .inHours
                                                .toString() +
                                            " hours ago";
                                      } else {
                                        countTime = todaysDate
                                                .difference(date)
                                                .inDays
                                                .toString() +
                                            " days ago";
                                      }

                                      // print("saved "+snapshot.data[index].isSaved.toString()+" index "+index.toString());
                                      return 
                                      snapshot.data[index].isreport ==
                                              "0"
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            // margin: EdgeInsets.all(2),
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(snapshot.data[index].User_image !=
                                                                            null
                                                                        ? imageUrlUser +
                                                                            snapshot
                                                                                .data[
                                                                                    index]
                                                                                .User_image
                                                                        : defaultUser),
                                                                    fit: BoxFit
                                                                        .cover),
                                                                border: Border.all(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .backgroundColor,
                                                                    width: 2),
                                                                shape: BoxShape
                                                                    .circle),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  if (id !=
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .user_id) {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ViewProfile(
                                                                                id: snapshot.data[index].user_id,
                                                                                LogedInid: id,
                                                                              )),
                                                                    );
                                                                  } else {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Profile()),
                                                                    );
                                                                  }
                                                                },
                                                                child: Text(
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .user_name,
                                                                  style: ThemeHelper().TextStyleMethod1(
                                                                      14,
                                                                      context,
                                                                      FontWeight
                                                                          .w500),
                                                                ),
                                                              ),
                                                              Text(
                                                                countTime,
                                                                style: ThemeHelper()
                                                                    .TextStyleMethod1(
                                                                        10,
                                                                        context,
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      id ==
                                                              snapshot
                                                                  .data[index]
                                                                  .user_id
                                                          ? Container()
                                                          : InkWell(
                                                              onTap: () async {
                                                                await ApiCall()
                                                                    .ReportPost(
                                                                        snapshot
                                                                            .data[index]
                                                                            .post_id,
                                                                        context);
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .background),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5))),
                                                                child: Text(
                                                                  "report",
                                                                  style: ThemeHelper().TextStyleMethod2(
                                                                      12,
                                                                      context,
                                                                      FontWeight
                                                                          .w600,
                                                                      Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .background),
                                                                ),
                                                              ),
                                                            )
                                                      //  IconButton(
                                                      //     onPressed: () async {
                                                      //      await ApiCall().ReportPost(
                                                      //           snapshot
                                                      //               .data[
                                                      //                   index]
                                                      //               .post_id,
                                                      //           context);
                                                      //       setState(() {});
                                                      //     },
                                                      //     icon: Icon(Icons
                                                      //         .report_gmailerrorred_rounded),
                                                      //     padding:
                                                      //         EdgeInsets
                                                      //             .all(0),
                                                      //   )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    height: 260,
                                                    decoration: BoxDecoration(
                                                        image: snapshot
                                                                    .data[index]
                                                                    .post_image !=
                                                                null
                                                            ? DecorationImage(
                                                                image: NetworkImage(
                                                                    imageUrlPost +
                                                                        snapshot
                                                                            .data[
                                                                                index]
                                                                            .post_image),
                                                                fit: BoxFit
                                                                    .cover)
                                                            : null,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      LikeIconWidget(
                                                          id: id,
                                                          postid: snapshot
                                                              .data[index]
                                                              .post_id,
                                                          isliked: snapshot
                                                              .data[index]
                                                              .isLiked),
                                                      SaveIconWidget(
                                                        postid: snapshot
                                                            .data[index]
                                                            .post_id,
                                                        id: id,
                                                        issaved: snapshot
                                                            .data[index]
                                                            .isSaved,
                                                      ),
                                                      id ==
                                                              snapshot
                                                                  .data[index]
                                                                  .user_id
                                                          ? IconButton(
                                                              onPressed: () {
                                                                ApiCall().DeleteUserPost(
                                                                    id,
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .post_id,
                                                                    context);
                                                                setState(() {});
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                            )
                                                          : Container(),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container();
                                    });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => newsFeedController.isDrawerOpen.value
                  ? Positioned(
                      top: 0,
                      left: 0,
                      child: NavbarWidget(),
                    )
                  : Container(),
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
               newsFeedController.isDrawerOpen.value = false;
              if (index == 0) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewsFeed()),
                // );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              } else if (index == 3) {
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

class SaveIconWidget extends StatefulWidget {
  SaveIconWidget({
    this.id,
    required this.issaved,
    this.postid,
    Key? key,
  }) : super(key: key);
  int issaved;
  var id, postid;

  @override
  State<SaveIconWidget> createState() => _SaveIconWidgetState();
}

class _SaveIconWidgetState extends State<SaveIconWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget.issaved == 0) {
          ApiCall().SavedPost(widget.id, widget.postid, context);
          setState(() {
            widget.issaved = 1;
          });
        } else {
          ApiCall().DeletePost(widget.id, widget.postid, context);
          setState(() {
            widget.issaved = 0;
          });
        }
      },
      icon: widget.issaved == 1
          ? Icon(
              Icons.bookmark,
              color: Theme.of(context).colorScheme.background,
            )
          : Icon(
              Icons.bookmark_border,
              color: Theme.of(context).colorScheme.background,
            ),
      padding: EdgeInsets.all(0),
    );
  }
}

class LikeIconWidget extends StatefulWidget {
  LikeIconWidget({
    required this.isliked,
    required this.id,
    required this.postid,
    Key? key,
  }) : super(key: key);
  int isliked;
  var id, postid;

  @override
  State<LikeIconWidget> createState() => _LikeIconWidgetState();
}

class _LikeIconWidgetState extends State<LikeIconWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (widget.isliked == 0) {
          ApiCall().LikedPost(widget.id, widget.postid, context);
          setState(() {
            widget.isliked = 1;
          });
        } else {
          await ApiCall().DeleteLikedPost(widget.id, widget.postid, context);
          setState(() {
            widget.isliked = 0;
          });
        }
      },
      icon: Icon(
        widget.isliked == 1 ? Icons.favorite_rounded : Icons.favorite_border,
        color: widget.isliked == 1 ? Colors.red : null,
      ),
      padding: EdgeInsets.all(0),
    );
  }
}

class WhatsOnYourMind extends StatelessWidget {
  const WhatsOnYourMind({
    Key? key,
    required this.image,
    required this.captionController,
  }) : super(key: key);

  final String image;
  final TextEditingController captionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Container(
            // margin: EdgeInsets.all(2),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        image != null ? imageUrlUser + image : defaultUser),
                    fit: BoxFit.cover),
                border: Border.all(
                    color: Theme.of(context).backgroundColor, width: 2),
                shape: BoxShape.circle),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: captionController,
                style: TextStyle(
                    color: Palette.darkGrey,
                    fontFamily: "Montserrat",
                    fontSize: 16),
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  // enabledBorder: const UnderlineInputBorder(
                  //     borderRadius: BorderRadius.all(
                  //         Radius.circular(30)),
                  //     borderSide: BorderSide(
                  //         color: Colors.grey,
                  //         width: 4))
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePost()),
                );
              },
              icon: Icon(
                Icons.collections,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
