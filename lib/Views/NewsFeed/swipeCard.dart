// // import 'package:example/content.dart';
// import 'package:flutter/material.dart';
// import 'package:swipe_cards/draggable_card.dart';
// import 'package:swipe_cards/swipe_cards.dart';

// // import 'content.dart';

// class SwipeCard extends StatefulWidget {
//   SwipeCard({Key? key}) : super(key: key);

//   // final String? title;

//   @override
//   _SwipeCardState createState() => _SwipeCardState();
// }

// class _SwipeCardState extends State<SwipeCard> {
//   List<SwipeItem> _swipeItems = <SwipeItem>[];
//   MatchEngine? _matchEngine;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   List<String> _names = [
//     "Red",
//     "Blue",
//     "Green",
//     "Yellow",
//     "Orange",
//     "Grey",
//     "Purple",
//     "Pink"
//   ];
//   List<Color> _colors = [
//     Colors.red,
//     Colors.blue,
//     Colors.green,
//     Colors.yellow,
//     Colors.orange,
//     Colors.grey,
//     Colors.purple,
//     Colors.pink
//   ];

//   @override
//   void initState() {
//     for (int i = 0; i < _names.length; i++) {
//       _swipeItems.add(SwipeItem(
//           content: Content(text: _names[i], color: _colors[i]),
//           likeAction: () {
//             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//               content: Text("Liked ${_names[i]}"),
//               duration: Duration(milliseconds: 500),
//             ));
//           },
//           nopeAction: () {
//             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//               content: Text("Nope ${_names[i]}"),
//               duration: Duration(milliseconds: 500),
//             ));
//           },
//           superlikeAction: () {
//             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//               content: Text("Superliked ${_names[i]}"),
//               duration: Duration(milliseconds: 500),
//             ));
//           },
//           onSlideUpdate: (SlideRegion? region) async {
//             print("Region $region");
//           }));
//     }

//     _matchEngine = MatchEngine(swipeItems: _swipeItems);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         // appBar: AppBar(
//         //   title: Text(widget.title!),
//         // ),
//         body: Container(
//             child: Stack(children: [
//           Container(
//             height: MediaQuery.of(context).size.height - kToolbarHeight,
//             child: SwipeCards(
//               matchEngine: _matchEngine!,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   alignment: Alignment.center,
//                   color: _swipeItems[index].content.color,
//                   child: Text(
//                     _swipeItems[index].content.text,
//                     style: TextStyle(fontSize: 100),
//                   ),
//                 );
//               },
//               onStackFinished: () {
//                 _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                   content: Text("Stack Finished"),
//                   duration: Duration(milliseconds: 500),
//                 ));
//               },
//               itemChanged: (SwipeItem item, int index) {
//                 print("item: ${item.content.text}, index: $index");
//               },
//               upSwipeAllowed: false,
//               fillSpace: true,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     _matchEngine!.currentItem?.nope();
//                   },
//                   child: Text("Nope")),
//               ElevatedButton(
//                   onPressed: () {
//                     _matchEngine!.currentItem?.superLike();
//                   },
//                   child: Text("Superlike")),
//               ElevatedButton(
//                   onPressed: () {
//                     _matchEngine!.currentItem?.like();
//                   },
//                   child: Text("Like"))
//             ],
//           )
//         ])));
//   }
// }

// class Content {
//   final String? text;
//   final Color? color;

//   Content({this.text, this.color});
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiCalling.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:video_player/video_player.dart';

import '../../Services/constants.dart';
import '../../classes/story.dart';
import 'package:http/http.dart' as http;

import 'ViewAllStories.dart';

class SwipeCard extends StatefulWidget {
  String user_id;
  SwipeCard({required this.user_id, Key? key}) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  String id = "0";

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("first_name"));
    id = prefs.getString("user_id")!;
    // String? islogin2 = prefs.getString("is_logged_in");
    setState(() {});
  }

  @override
  void initState() {
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.background),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Container(
              //       // margin: EdgeInsets.all(2),
              //       height: 35,
              //       width: 35,
              //       decoration: BoxDecoration(
              //           image: DecorationImage(
              //               image: NetworkImage(storyitem[0].image != ""
              //                   ? imageUrlUser + storyitem[0].image
              //                   : defaultUser),
              //               fit: BoxFit.cover),
              //           border: Border.all(
              //               color: Theme.of(context).backgroundColor,
              //               width: 2),
              //           shape: BoxShape.circle),
              //     ),
              //     Text(
              //       storyitem[0].user_name,
              //       style: ThemeHelper().TextStyleMethod2(
              //           12,
              //           context,
              //           FontWeight.w600,
              //           Theme.of(context).colorScheme.background),
              //     ),
              //   ],
              // ),
              widget.user_id == id
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllStoryPageView(
                                    user_id: widget.user_id,
                                  )),
                        );
                      },
                      child: Text(
                        "View All",
                        style: ThemeHelper().TextStyleMethod2(
                            12,
                            context,
                            FontWeight.w600,
                            Theme.of(context).colorScheme.background),
                      ),
                    )
                  : Container(),
              // IconButton(
              //     onPressed: () async {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => StoryPageView(
              //                   user_id: widget.user_id,
              //                 )),
              //       );
              //       // print(StoryItem.);
              //       // await ApiCall().DeleteLikedPost(
              //       //     id, context);
              //       // ApiCall().DeleteLikedPost(
              //       //     id, context);
              //       setState(() {});
              //     },
              //     icon: Icon(
              //       Icons.delete,
              //       color: Theme.of(context).colorScheme.background,
              //     ))
              // : Container()
            ],
          )),
      body: SafeArea(
        child: Stack(
          children: [
            // BackgroudCurveWidget(),
            CardsStackWidget(user_id: widget.user_id, currentUserId: id),
          ],
        ),
      ),
    );
  }
}

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.lightGrey,
      shape: const CircleBorder(),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: IconButton(onPressed: onPressed, icon: icon),
      ),
    );
  }
}

class BackgroudCurveWidget extends StatelessWidget {
  const BackgroudCurveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
        ),
        gradient: LinearGradient(
          colors: <Color>[
            Palette.lightGolden,
            Palette.DarkGolden,
          ],
        ),
      ),
      // child: const Padding(
      //   padding: EdgeInsets.only(top: 46.0, left: 20.0),
      //   child: Text(
      //     'Discover',
      //     style: TextStyle(
      //       fontFamily: 'Nunito',
      //       fontWeight: FontWeight.w800,
      //       color: Colors.white,
      //       fontSize: 36,
      //     ),
      //   ),
      // ),
    );
  }
}

class CardsStackWidget extends StatefulWidget {
  String user_id, currentUserId;
  CardsStackWidget(
      {required this.user_id, required this.currentUserId, Key? key})
      : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget>
    with SingleTickerProviderStateMixin {
  List<story> draggableItems = [];
  getStories() async {
    var url = Uri.parse(base_url + ApiUrl.getStoryByID(widget.user_id, true));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        story item = story(d["image"], d["user_name"], d["post_image"],
            d["user_id"], "", d["isVedio"]
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
        draggableItems.add(item);
      }
    setState(() {});
    // for (i = 0; i < draggableItems.length; i++) {
    //   draggableItems.add(StoryItem.
    //   pageImage(
    //       url: imageUrlPost + storyitem[i].post_image, controller: controller));
    // }
    // setState(() {
    //   isloading = false;
    // });
    // return storyitem;
  }

  // List<Profile> draggableItems = [
  //   const Profile(
  //       name: 'Rohini',
  //       distance: '10 miles away',
  //       imageAsset: 'assets/images/post.png'),
  //   const Profile(
  //       name: 'Rohini',
  //       distance: '10 miles away',
  //       imageAsset: 'assets/images/post.png'),
  //   const Profile(
  //       name: 'Rohini',
  //       distance: '10 miles away',
  //       imageAsset: 'assets/images/post.png'),
  //   const Profile(
  //       name: 'Rohini',
  //       distance: '10 miles away',
  //       imageAsset: 'assets/images/post.png'),
  //   const Profile(
  //       name: 'Rohini',
  //       distance: '10 miles away',
  //       imageAsset: 'assets/images/post.png'),
  // ];

  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;
  bool opened = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        draggableItems.removeLast();
        _animationController.reset();

        swipeNotifier.value = Swipe.none;
        print("object");
      }
    });
    getStories();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //  if ( opened) 
        //  IconButton(
        //       icon: Icon(Icons.arrow_back,
        //           color: Theme.of(context).colorScheme.background),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       }),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ValueListenableBuilder(
              valueListenable: swipeNotifier,
              builder: (context, swipe, _) {
                // if (draggableItems.length == 0 && opened) {
                //   Navigator.pop(context);
                // }
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: List.generate(draggableItems.length, (index) {
                   
                    if (index == draggableItems.length - 1) {
                    //  opened = true;
                      return PositionedTransition(
                        rect: RelativeRectTween(
                          begin: RelativeRect.fromSize(
                              const Rect.fromLTWH(0, 0, 580, 340),
                              const Size(580, 340)),
                          end: RelativeRect.fromSize(
                              Rect.fromLTWH(
                                  swipe != Swipe.none
                                      ? swipe == Swipe.left
                                          ? -300
                                          : 300
                                      : 0,
                                  0,
                                  580,
                                  340),
                              const Size(580, 340)),
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        )),
                        child: RotationTransition(
                          turns: Tween<double>(
                                  begin: 0,
                                  end: swipe != Swipe.none
                                      ? swipe == Swipe.left
                                          ? -0.1 * 0.3
                                          : 0.1 * 0.3
                                      : 0.0)
                              .animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0, 0.4,
                                  curve: Curves.easeInOut),
                            ),
                          ),
                          child: DragWidget(
                            profile: draggableItems[index],
                            index: index,
                            swipeNotifier: swipeNotifier,
                            isLastCard: true,
                          ),
                        ),
                      );
                    } else {
                      return DragWidget(
                        profile: draggableItems[index],
                        index: index,
                        swipeNotifier: swipeNotifier,
                      );
                    }
                  }),
                );
              }),
        ),
        Positioned(
          bottom: -20,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 46.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButtonWidget(
                  onPressed: () {
                    swipeNotifier.value = Swipe.left;
                    _animationController.forward();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                ActionButtonWidget(
                  onPressed: () async {
                    
                    await HttpService().addToExchangeAndConnection(
                        widget.currentUserId,
                        widget.user_id,
                        context,
                        ApiUrl.addToExchange);
                    swipeNotifier.value = Swipe.right;
                    _animationController.forward();
                    
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) {
              
              setState(() {
                draggableItems.removeAt(index);
              });
            },
          ),
        ),
        Positioned(
          right: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) async {
                    await HttpService().addToExchangeAndConnection(
                        widget.currentUserId,
                        widget.user_id,
                        context,
                        ApiUrl.addToExchange);
                    swipeNotifier.value = Swipe.right;
                    _animationController.forward();
              setState(() {
                draggableItems.removeAt(index);
              });
            },
          ),
        ),
      ],
    );
  }
}

class DragWidget extends StatefulWidget {
  const DragWidget({
    Key? key,
    required this.profile,
    required this.index,
    required this.swipeNotifier,
    this.isLastCard = false,
  }) : super(key: key);
  final story profile;
  final int index;
  final ValueNotifier<Swipe> swipeNotifier;
  final bool isLastCard;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable<int>(
        // Data is the value this Draggable stores.
        data: widget.index,
        feedback: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder(
            valueListenable: widget.swipeNotifier,
            builder: (context, swipe, _) {
              return RotationTransition(
                turns: widget.swipeNotifier.value != Swipe.none
                    ? widget.swipeNotifier.value == Swipe.left
                        ? const AlwaysStoppedAnimation(-15 / 360)
                        : const AlwaysStoppedAnimation(15 / 360)
                    : const AlwaysStoppedAnimation(0),
                child: Stack(
                  children: [
                    ProfileCard(profile: widget.profile),
                    widget.swipeNotifier.value != Swipe.none
                        ? widget.swipeNotifier.value == Swipe.right
                            ? Positioned(
                                top: 40,
                                left: 20,
                                child: Transform.rotate(
                                  angle: 12,
                                  child: TagWidget(
                                    text: 'LIKE',
                                    color: Colors.green[400]!,
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 50,
                                right: 24,
                                child: Transform.rotate(
                                  angle: -12,
                                  child: TagWidget(
                                    text: 'NOT INTERESTED',
                                    color: Colors.red[400]!,
                                  ),
                                ),
                              )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
        onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
          if (dragUpdateDetails.delta.dx > 0 &&
              dragUpdateDetails.globalPosition.dx >
                  MediaQuery.of(context).size.width / 2) {
            widget.swipeNotifier.value = Swipe.right;
          }
          if (dragUpdateDetails.delta.dx < 0 &&
              dragUpdateDetails.globalPosition.dx <
                  MediaQuery.of(context).size.width / 2) {
            widget.swipeNotifier.value = Swipe.left;
          }
        },
        onDragEnd: (drag) {
          widget.swipeNotifier.value = Swipe.none;
        },
        onDragCompleted: () {
          print("finag");
        },

        childWhenDragging: Container(
          color: Colors.transparent,
        ),

        //This will be visible when we press action button
        child: ValueListenableBuilder(
            valueListenable: widget.swipeNotifier,
            builder: (BuildContext context, Swipe swipe, Widget? child) {
              return Stack(
                children: [
                  ProfileCard(profile: widget.profile),
                  // heck if this is the last card and Swipe is not equal to Swipe.none
                  swipe != Swipe.none && widget.isLastCard
                      ? swipe == Swipe.right
                          ? Positioned(
                              top: 40,
                              left: 20,
                              child: Transform.rotate(
                                angle: 12,
                                child: TagWidget(
                                  text: 'LIKE',
                                  color: Colors.green[400]!,
                                ),
                              ),
                            )
                          : Positioned(
                              top: 50,
                              right: 24,
                              child: Transform.rotate(
                                angle: -12,
                                child: TagWidget(
                                  text: 'DISLIKE',
                                  color: Colors.red[400]!,
                                ),
                              ),
                            )
                      : const SizedBox.shrink(),
                ],
              );
            }),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.profile}) : super(key: key);
  final story profile;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network(imageUrlPost + widget.profile.post_image)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
          _controller!.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    print(imageUrlPost + widget.profile.post_image);
    return Container(
      height: 580,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.profile.isVedio == "1"
                  ? Stack(
                      children: [
                        _controller!.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              )
                            : Container(color: Colors.black,),
                        Center(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller!.value.isPlaying
                                        ? _controller!.pause()
                                        : _controller!.play();
                                  });
                                },
                                icon: Icon(
                                   _controller!.value.isPlaying?Icons.pause_circle:Icons.play_circle,
                                  color: Colors.white,
                                  size: 50,
                                )))
                      ],
                    )
                  : Image.network(
                      imageUrlPost + widget.profile.post_image,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 80,
              width: 340,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.profile.user_name,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                      ),
                    ),
                    Text(
                      widget.profile.user_name,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 36,
        ),
      ),
    );
  }
}

enum Swipe { left, right, none }

class Profile {
  const Profile({
    required this.name,
    required this.distance,
    required this.imageAsset,
  });
  final String name;
  final String distance;
  final String imageAsset;
}
