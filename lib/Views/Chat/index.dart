import 'dart:convert';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/ChatController.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/AddTopic/index.dart';
import 'package:soloconneckt/Views/ArtGallery/index.dart';
import 'package:soloconneckt/Views/Chat/DirectChatScreen.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/Profile/index.dart';
import 'package:soloconneckt/Views/QrCode/index.dart';
import 'package:soloconneckt/Widgets/IconList.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/classes/DirectChat.dart';

import '../../Services/ApiCalling.dart';
import '../../Services/constants.dart';
import '../../classes/ChatGroup.dart';
import 'ChatScreen.dart';

ChatController _chatController = Get.find();

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool fav = false;
  int tag = 0;
  var currentIndex = 1;

  int tabindex = 0;
  // List<String> options = [
  //   'Featured Topics',
  //   'Most Recent',
  //   'Related Topics',
  // ];

  String id = "";

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("user_id")!;
    // String? islogin2 = prefs.getString("is_logged_in");
    setState(() {});
    // getChat();
    // getDirectChat();
    _chatController.getChat(id);
  }

  Future<List<DirectChat_item>> getDirectChat() async {
    var url = Uri.parse(base_url + ApiUrl.getDirectChat(id));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    List<DirectChat_item> Directchat = [];
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        DirectChat_item item = DirectChat_item(
            d["id"],
            d["image"],
            d["message_content"],
            d["user_name"],
            d["user_id"],
            d["is_blocked"]);
        // ignore: invalid_use_of_protected_member
        Directchat.add(item);
        // print(users[0].date);
      }

    print(" blockedd ${Directchat[0].is_blocked}");
    ;

    return Directchat;
  }

  Future<List<Chat_item>> getChat() async {
    var url = Uri.parse(base_url + ApiUrl.getChat(id));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    List<Chat_item> chatlist = [];
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      chatlist.clear();
    for (var d in JsonData) {
      Chat_item item = Chat_item(
        d["id"],
        d["image"],
        d["ispublic"],
        d["name"],
        d["user_id"],
        d["isLiked"],
      );
      // ignore: invalid_use_of_protected_member
      chatlist.add(item);
      print(chatlist[0].name);
    }
    return chatlist;
    // isloading.value=false;
  }

  @override
  void initState() {
    addStringToSF();
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forum(s)",
                      style: ThemeHelper()
                          .TextStyleMethod1(18, context, FontWeight.w600),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // ChipsChoice<int>.single(
              //   value: tag,
              //   onChanged: (val) => setState(() => tag = val),
              //   choiceItems: C2Choice.listFrom<int, String>(
              //     source: options,
              //     value: (i, v) => i,
              //     label: (i, v) => v,
              //     tooltip: (i, v) => v,
              //   ),
              //   choiceBuilder: (item) {
              //     return InkWell(
              //       onTap: () {
              //         item.select(!item.selected);
              //       },
              //       child: Container(
              //         margin: EdgeInsets.only(right: 10),
              //         decoration: BoxDecoration(
              //             color: item.selected
              //                 ? Theme.of(context).colorScheme.primaryVariant
              //                 : Theme.of(context).backgroundColor,
              //             border: Border.all(
              //                 color:
              //                     Theme.of(context).colorScheme.primaryVariant,
              //                 width: 1.5),
              //             borderRadius: BorderRadius.all(Radius.circular(30))),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 8.0, vertical: 5),
              //           child: Text(
              //             item.label,
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 color: item.selected
              //                     ? Theme.of(context).backgroundColor
              //                     : Theme.of(context)
              //                         .colorScheme
              //                         .primaryVariant,
              //                 fontWeight: FontWeight.normal,
              //                 fontFamily: "Montserrat"),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: DefaultTabController(
                  length: 2,
                  child: TabBar(
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
                        fontSize: 16,
                        fontFamily: "Montserrat"),
                    tabs: [
                      Tab(
                        text: 'Public',
                      ),
                      Tab(
                        text: 'Private',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (tabindex == 0)
                FutureBuilder<List<Chat_item>>(
                    future: getChat(),
                    builder: ((BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue)),
                        );
                      } else if (snapshot.data.length == 0) {
                        return Container(
                          child: Center(
                            child: Text(
                              "Your RecentGroup chats Will Show here...",
                              style: ThemeHelper().TextStyleMethod1(
                                  16, context, FontWeight.w600),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _chatController.chatlist.length,
                          itemBuilder: (BuildContext, index) => chatBubble(
                            // index: index,
                            currentUser: id,
                            image:  snapshot.data[index].image,
                            id:  snapshot.data[index].id,
                            name:  snapshot.data[index].name,
                            isLiked:  snapshot.data[index].isLiked,
                          ),
                        );
                      }
                    }))
              else
                FutureBuilder<List<DirectChat_item>>(
                    future: getDirectChat(),
                    builder: ((BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue)),
                        );
                      } else if (snapshot.data.length == 0) {
                        return Container(
                          child: Center(
                            child: Text(
                              "Your Recent chats Will Show here...",
                              style: ThemeHelper().TextStyleMethod1(
                                  16, context, FontWeight.w600),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext, index) => chatBubble(
                                  currentUser: id,
                                  image: snapshot.data[index].image,
                                  id: snapshot.data[index].user_id,
                                  name: snapshot.data[index].user_name,
                                  message: snapshot.data[index].message_content,
                                  isBlocked: snapshot.data[index].is_blocked,
                                ));
                      }
                    }))
            ],
          ),
        ),
      ),
      floatingActionButton: tabindex == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primaryVariant,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTopic(
                            id: id,
                          )),
                );
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).backgroundColor,
              ))
          : Container(),
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
              }
              // else if (index == 1) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Chat()),
              //   );
              // }
              else if (index == 2) {
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

class chatBubble extends StatefulWidget {
  String image, id, name, message, currentUser, isBlocked;
  int isLiked;
  chatBubble({
    required this.currentUser,
    required this.image,
    required this.id,
    required this.name,
    this.message = "",
    this.isBlocked = "0",
    this.isLiked = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<chatBubble> createState() => _chatBubbleState();
}

class _chatBubbleState extends State<chatBubble> {
  @override
  Widget build(BuildContext context) {
    // print(widget.currentUser);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: InkWell(
        onTap: () {
          if (widget.message == "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleGroupChatScreen(
                        id: widget.id,
                        image: imageUrlGroupChat + widget.image,
                        name: widget.name,
                      )),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DirectUserChat(
                        id: widget.id,
                        image: widget.image == ""
                            ? defaultUser
                            : imageUrlUser + widget.image,
                        name: widget.name,
                        isBlocked: widget.isBlocked,
                      )),
            );
          }
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.message == ""
                          ? NetworkImage(widget.image != ""
                              ? imageUrlGroupChat + widget.image
                              : defaultUser)
                          : NetworkImage(widget.image != ""
                              ? imageUrlUser + widget.image
                              : defaultUser),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: ThemeHelper()
                      .TextStyleMethod1(14, context, FontWeight.bold),
                ),
                widget.message == ""
                    ? Text(
                        "Comment",
                        style: ThemeHelper()
                            .TextStyleMethod1(10, context, FontWeight.normal),
                      )
                    : Text(
                        widget.message,
                        style: ThemeHelper().TextStyleMethod2(
                            14, context, FontWeight.normal, Colors.grey),
                      ),
                widget.message == ""
                    ? Container(
                        margin: EdgeInsets.only(top: 4),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Text(
                          "Comment",
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).backgroundColor,
                              fontFamily: "Montserrat"),
                        ),
                      )
                    : Container()
              ],
            ),
            Spacer(),
            widget.message == ""
                ? Row(
                    children: [
                      widget.currentUser == widget.id
                          ? IconButton(
                              onPressed: () {
                                ApiCall().DeleteGroupChat(
                                    widget.currentUser, context);
                                _chatController.getChat(widget.currentUser);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete),
                            )
                          : Container(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_box_rounded,
                        ),
                        color: Palette.secondaryColor,
                        // index % 2 == 0
                        //     ? Colors.red
                        //     : Palette.secondaryColor,
                      ),
                      LikeChatWidget(
                          currentUser: widget.currentUser,
                          id: widget.id,
                          isLiked: widget.isLiked),
                    ],
                  )
                : IconButton(onPressed: () {}, icon: Icon(Icons.reply_rounded)),
          ],
        ),
      ),
    );
  }
}

class LikeChatWidget extends StatefulWidget {
  LikeChatWidget({
    required this.isLiked,
    required this.currentUser,
    required this.id,
    Key? key,
  }) : super(key: key);

  int isLiked;
  var currentUser, id;

  @override
  State<LikeChatWidget> createState() => _LikeChatWidgetState();
}

class _LikeChatWidgetState extends State<LikeChatWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget.isLiked == 0) {
          ApiCall().LikedGroup(widget.currentUser, widget.id, context);

          setState(() {
            widget.isLiked = 1;
          });
        } else {
          ApiCall().DeleteLikedGroup(widget.currentUser, widget.id, context);

          setState(() {
            widget.isLiked = 0;
          });
        }
        _chatController.getChat(widget.currentUser);
      },
      icon: Icon(
        widget.isLiked == 1 ? Icons.favorite_rounded : Icons.favorite_border,
        color: widget.isLiked == 1 ? Colors.red : null,
      ),
      padding: EdgeInsets.all(0),
    );
  }
}

// for try getx purpose
class chatBubble2 extends StatefulWidget {
  int index;

  var message;

  var currentUser;

  var isBlocked;

  chatBubble2({
    required this.index,
    this.message = "",
    this.isBlocked = "0",
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  State<chatBubble2> createState() => _chatBubble2State();
}

class _chatBubble2State extends State<chatBubble2> {
  @override
  Widget build(BuildContext context) {
    // print(widget.currentUser);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: InkWell(
        onTap: () {
          if (widget.message == "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleGroupChatScreen(
                        id: _chatController.chatlist[widget.index].id,
                        image: imageUrlGroupChat +
                            _chatController.chatlist[widget.index].image,
                        name: _chatController.chatlist[widget.index].name,
                      )),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DirectUserChat(
                        id: _chatController.chatlist[widget.index].id,
                        image: _chatController.chatlist[widget.index].image ==
                                ""
                            ? defaultUser
                            : imageUrlUser +
                                _chatController.chatlist[widget.index].image,
                        name: _chatController.chatlist[widget.index].name,
                        isBlocked: widget.isBlocked,
                      )),
            );
          }
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.message == ""
                          ? NetworkImage(
                              _chatController.chatlist[widget.index].image != ""
                                  ? imageUrlGroupChat +
                                      _chatController
                                          .chatlist[widget.index].image
                                  : defaultUser)
                          : NetworkImage(
                              _chatController.chatlist[widget.index].image != ""
                                  ? imageUrlUser +
                                      _chatController
                                          .chatlist[widget.index].image
                                  : defaultUser),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _chatController.chatlist[widget.index].name,
                  style: ThemeHelper()
                      .TextStyleMethod1(14, context, FontWeight.bold),
                ),
                widget.message == ""
                    ? Text(
                        "Comment",
                        style: ThemeHelper()
                            .TextStyleMethod1(10, context, FontWeight.normal),
                      )
                    : Text(
                        widget.message,
                        style: ThemeHelper().TextStyleMethod2(
                            14, context, FontWeight.normal, Colors.grey),
                      ),
                widget.message == ""
                    ? Container(
                        margin: EdgeInsets.only(top: 4),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Text(
                          "Comment",
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).backgroundColor,
                              fontFamily: "Montserrat"),
                        ),
                      )
                    : Container()
              ],
            ),
            Spacer(),
            widget.message == ""
                ? Row(
                    children: [
                      widget.currentUser ==
                              _chatController.chatlist[widget.index].id
                          ? IconButton(
                              onPressed: () {
                                ApiCall().DeleteGroupChat(
                                    widget.currentUser, context);
                                _chatController.getChat(widget.currentUser);
                                // setState(() {});
                              },
                              icon: Icon(Icons.delete),
                            )
                          : Container(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_box_rounded,
                        ),
                        color: Palette.secondaryColor,
                        // index % 2 == 0
                        //     ? Colors.red
                        //     : Palette.secondaryColor,
                      ),
                      IconButton(
                        onPressed: () {
                          if (_chatController.chatlist[widget.index].isLiked ==
                              0) {
                            ApiCall().LikedGroup(
                                widget.currentUser,
                                _chatController.chatlist[widget.index].id,
                                context);
                            _chatController.chatlist[widget.index].isLiked = 1;
                            // _chatController.getChat(widget.currentUser);
                            // setState(() {
                            //    _chatController.getChat(widget.currentUser);
                            // });
                          } else {
                            ApiCall().DeleteLikedGroup(
                                widget.currentUser,
                                _chatController.chatlist[widget.index].id,
                                context);
                            _chatController.chatlist[widget.index].isLiked = 0;
                            // _chatController.getChat(widget.currentUser);
                            // setState(() {
                            //    _chatController.getChat(widget.currentUser);
                            // });
                          }
                        },
                        icon: Obx(
                          () => Icon(
                            _chatController.chatlist[widget.index].isLiked == 1
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                            color: _chatController
                                        .chatlist[widget.index].isLiked ==
                                    1
                                ? Colors.red
                                : null,
                          ),
                        ),
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  )
                : IconButton(onPressed: () {}, icon: Icon(Icons.reply_rounded)),
          ],
        ),
      ),
    );
  }
}
