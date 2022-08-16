import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Views/Interests/menuDropDown.dart';
import 'package:soloconneckt/Views/VerificationPage/index.dart';
import 'package:http/http.dart' as http;
import 'package:textfield_tags/textfield_tags.dart';

import '../../Services/Apis.dart';
import '../../Services/constants.dart';
import '../../Styles/ThemeHelper.dart';
import '../../Styles/palette.dart';
import '../../Widgets/ShowResponse.dart';

class Interests extends StatefulWidget {
  String email, password, name, number;
  File? imageFile;
  bool isEdit;
  Interests(
      {this.email = "",
      this.name = "",
      this.password = "",
      this.number = "",
      this.imageFile,
      this.isEdit = false,
      key})
      : super(key: key);

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  String id = "";
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString("user_id")!;
    setState(() {});
    getUserInterest();
  }

  String selectedValue = "Select Interest";
  bool isloading = true;
  bool isloading2 = true;
  var data, data2;

  void getInterest() async {
    var url = Uri.parse(base_url + ApiUrl.getInterest());
    print(url);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        isloading = false;
      });
    } else {
      print("eror");
    }
  }

  void getUserInterest() async {
    var url = Uri.parse(base_url + ApiUrl.getUserInterest(id));
    print(url);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        data2 = json.decode(response.body);
        isloading2 = false;
      });
    } else {
      print("eror");
    }
  }

  @override
  void initState() {
    isloading = true;
    getInterest();
    if (widget.isEdit) addStringToSF();
    _controller = TextfieldTagsController();
    super.initState();
  }

  double? _distanceToField;
  TextfieldTagsController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  addInterest(String tag) {
    _controller!.addTag = tag;
  }

  @override
  Widget build(BuildContext context) {

    List<Interest> editInterestList=[],InterestList=[]; 

   if(isloading == false)
    InterestList = List<Interest>.from(data.map((i) {
      return Interest.fromJSON(i);
    }));
    
    if (widget.isEdit)
      editInterestList = List<Interest>.from(data2.map((i) {
        return Interest.fromJSON(i);
      }));

    // var list = [];
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: isloading == false
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 30,
                                ))
                          ],
                        ),
                        Hero(
                            tag: "pic",
                            child: Image.asset(
                              "assets/images/whitelogo.png",
                              width: 250,
                              height: 250,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Select your intrest*",
                              textAlign: TextAlign.start,
                              style: ThemeHelper().TextStyleMethod2(
                                  12, context, FontWeight.w600, Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFieldTags(
                          textfieldTagsController: _controller,
                          initialTags: [
                            if (widget.isEdit)
                              for (int i = 0; i < editInterestList.length; i++)
                                editInterestList[i].name
                            else
                              InterestList[0].name,
                          ],
                          textSeparators: const [' ', ','],
                          letterCase: LetterCase.normal,
                          validator: (String tag) {
                            if (tag == 'php') {
                              return 'No, please just no';
                            } else if (_controller!.getTags!.contains(tag)) {
                              return 'you already entered that';
                            }
                            return null;
                          },
                          inputfieldBuilder: (context, tec, fn, error,
                              onChanged, onSubmitted) {
                            return ((context, sc, tags, onTagDelete) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextField(
                                  // maxLines: 4,
                                  style: ThemeHelper().TextStyleMethod2(
                                    16,
                                    context,
                                    FontWeight.bold,
                                    Palette.Black,
                                  ),
                                  controller: tec,
                                  focusNode: fn,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return MenuDialogWidget(
                                                InterestList: InterestList,
                                                addinterest: addInterest,
                                              );
                                            });
                                      },
                                    ),
                                    isDense: true,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Palette.dimGrey, width: 4)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    hintText: _controller!.hasTags
                                        ? ''
                                        : "Enter interests...",
                                    errorText: error,
                                    prefixIconConstraints: BoxConstraints(
                                        maxWidth: _distanceToField! * 0.8),
                                    prefixIcon: tags.isNotEmpty
                                        ? SingleChildScrollView(
                                            controller: sc,
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                children:
                                                    tags.map((String tag) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.black,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        '$tag',
                                                        style: ThemeHelper()
                                                            .TextStyleMethod2(
                                                                12,
                                                                context,
                                                                FontWeight.w600,
                                                                Colors.white),
                                                      ),
                                                      onTap: () {
                                                        print("$tag selected");
                                                      },
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    InkWell(
                                                      child: const Icon(
                                                        Icons.cancel,
                                                        size: 14.0,
                                                        color: Color.fromARGB(
                                                            255, 233, 233, 233),
                                                      ),
                                                      onTap: () {
                                                        onTagDelete(tag);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList()),
                                          )
                                        : null,
                                  ),
                                  onChanged: onChanged,
                                  onSubmitted: onSubmitted,
                                ),
                              );
                            });
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            // print(_controller!.getTags);
                            if (_controller!.hasTags != '') {
                              _controller!.getTags;
                              if (widget.isEdit) {
                                HttpService().updateUserInterest(
                                    id,
                                    _controller!.getTags,
                                    context,
                                    ApiUrl.updateUserInterest);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerificationPage(
                                            email: widget.email,
                                            name: widget.name,
                                            password: widget.password,
                                            number: widget.number,
                                            imageFile: widget.imageFile,
                                            interest: _controller!.getTags,
                                          )),
                                );
                              }
                            } else {
                              ShowResponse(
                                  "Please select an interest.", context);
                            }
                          },
                          child: Container(
                            height: 58,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Palette.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                              child: Text(
                                widget.isEdit ? "Update" : "Get Started",
                                style: ThemeHelper().TextStyleMethod2(
                                    16, context, FontWeight.bold, Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ));
  }
}

class Interest {
  String id, name;
  Interest({required this.id, required this.name});

  factory Interest.fromJSON(Map<String, dynamic> json) {
    return Interest(
      id: json["interest_id"],
      name: json["name"],
    );
  }
}

// class AppProfile {
//   final String name;

//   const AppProfile(this.name);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AppProfile &&
//           runtimeType == other.runtimeType &&
//           name == other.name;

//   @override
//   int get hashCode => name.hashCode;

//   @override
//   String toString() {
//     return name;
//   }
// }
// InterestList(),
                        // ChipsInput(
                        //   key: _chipKey,
                        //   initialValue: [
                        //     AppProfile(InterestList[0].name),
                        //   ],
                        //   autofocus: true,
                        //   allowChipEditing: true,
                        //   // keyboardAppearance: Brightness.dark,
                        //   suggestionsBoxMaxHeight: 200,
                        //   textCapitalization: TextCapitalization.words,
                        //   enabled: true,
                        //   // maxChips: 5,
                        //   textStyle: ThemeHelper().TextStyleMethod2(
                        //     16,
                        //     context,
                        //     FontWeight.bold,
                        //     Palette.Black,
                        //   ),
                        //   decoration: TextFormFeildDecoration(),
                        //   findSuggestions: (String query) {
                        //     // print("Query: '$query'");
                        //     if (query.isNotEmpty) {
                        //       var lowercaseQuery = query.toLowerCase();
                        //       return InterestList.where((profile) {
                        //         return profile.name
                        //             .toLowerCase()
                        //             .contains(query.toLowerCase());
                        //       }).toList(growable: false)
                        //         ..sort((a, b) => a.name
                        //             .toLowerCase()
                        //             .indexOf(lowercaseQuery)
                        //             .compareTo(b.name
                        //                 .toLowerCase()
                        //                 .indexOf(lowercaseQuery)));
                        //     }
                        //     // return <AppProfile>[];
                        //     return InterestList;
                        //   },
                        //   onChanged: (data) {
                        //     list=data;
                        //     list.forEach((element) {
                        //       print(element.name);
                        //     });

                        //   },
                        //   chipBuilder: (context, state, dynamic profile) {
                        //     return InputChip(
                        //       key: ObjectKey(profile),
                        //       label: Text(profile.name),
                        //       // avatar: CircleAvatar(
                        //       //   backgroundImage: NetworkImage(profile.imageUrl),
                        //       // ),
                        //       onDeleted: () => state.deleteChip(profile),
                        //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //     );
                        //   },
                        //   suggestionBuilder: (context, state, dynamic profile) {
                        //     return Container(
                        //       color: Colors.white,
                        //       child: ListTile(
                        //         textColor: Colors.black,
                        //         key: ObjectKey(profile),
                        //         // leading: CircleAvatar(
                        //         //   backgroundImage: NetworkImage(profile.imageUrl),
                        //         // ),
                        //         title: Text(profile.name),
                        //         // subtitle: Text(profile.email),
                        //         onTap: () => state.selectSuggestion(profile),
                        //       ),
                        //     );
                        //   },
                        // ),