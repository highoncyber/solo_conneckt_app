import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/Chat/index.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/Profile/index.dart';
import 'package:soloconneckt/Views/QrCode/index.dart';
import 'package:soloconneckt/Widgets/IconList.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/classes/post.dart';

class ArtGallery extends StatefulWidget {
  const ArtGallery({Key? key}) : super(key: key);

  @override
  State<ArtGallery> createState() => _ArtGalleryState();
}

class _ArtGalleryState extends State<ArtGallery> {
  List<Post_item> post = [];
  bool isloading = true;

  getPost() async {
    var url = Uri.parse(base_url + ApiUrl.getPost);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        Post_item item = Post_item(
            "",
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

  var currentIndex = 3;

  @override
  void initState() {
    getPost();
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
        title:  Text(
            "SOLO CONNECKT",
            style: ThemeHelper().TextStyleMethod2(20, context, FontWeight.w600,Theme.of(context).colorScheme.primaryVariant),
          ),
      leading:IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),),
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
                      "Art Gallery",
                      style: ThemeHelper()
                          .TextStyleMethod1(18, context, FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Explore",
                      style: ThemeHelper()
                          .TextStyleMethod1(16, context, FontWeight.w600),
                    ),
                  ],
                ),
              ),
              isloading == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: post.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              image: post[index].post_image != null
                                  ? DecorationImage(
                                      image: NetworkImage(imageUrlPost +
                                          post[index].post_image),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.all(2),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(post[index]
                                                            .User_image !=
                                                        null
                                                    ? imageUrlUser +
                                                        post[index].User_image
                                                    : defaultUser),
                                                fit: BoxFit.cover),
                                            shape: BoxShape.circle),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post[index].user_name,
                                              style: ThemeHelper().TextStyleMethod1(
                                                  14, context, FontWeight.w600),
                                            ),
                                            Text(
                                              "0 views",
                                              style: ThemeHelper().TextStyleMethod1(
                                                  10, context, FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primaryVariant,
                    )
            ],
          ),
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
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              } 
              // else if (index == 3) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ArtGallery()),
              //   );
              // } 
              else if (index == 4) {
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
