import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiCalling.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:http/http.dart' as http;

import '../../Services/constants.dart';
import '../../Styles/ThemeHelper.dart';
import '../../Widgets/textFeildDecoration.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
   String selectedValue = "Select Interest";
  bool isloading=true;
  var data;

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

  @override
  void initState() {
    isloading=true;
    getInterest();
    addStringToSF();
    super.initState();
  }

  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _getFromGallery();
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _getFromCamera();
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Get from gallery
  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    ShowResponse("Loading", context);
    if (pickedFile != null) {
      
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    _cropImage(pickedFile?.path);
  }

  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      imageFile = croppedImage;
      setState(() {});
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    ShowResponse("Loading", context);
    if (pickedFile != null) {
      
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    _cropImage(pickedFile?.path);
  }
  final captionController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
   String usename = "", email = "", image = "",id="";
  bool islogin = false;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email")!;
    image = prefs.getString("image")!;
    id = prefs.getString("user_id")!;
    // String? islogin2 = prefs.getString("is_logged_in");
    setState(() {});
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title:  Text(
            "New Post",
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
          child:isloading==false? SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: 350,
                height: 350,
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: imageFile != null
                      ? DecorationImage(
                          image: FileImage(
                            imageFile!,
                          ),
                          fit: BoxFit.cover)
                      : null,
                  // border: Border.all(width: 5, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: imageFile == null
                    ? Icon(
                        Icons.person,
                        color: Colors.grey.shade300,
                        size: 70.0,
                      )
                    : Container(),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Interest*",
                      style: ThemeHelper().TextStyleMethod2(
                          12,
                          context,
                          FontWeight.w600,
                          Theme.of(context).colorScheme.primaryVariant),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InterestList(),
                    // TextFormField(
                    //   controller: captionController,
                    //   validator: (value) {
                    //     if (value != null && value.trim().length < 3) {
                    //       return 'This field requires a minimum of 3 characters';
                    //     }

                    //     return null;
                    //   },
                    //   style: TextStyle(
                    //       color: Palette.darkGrey,
                    //       fontFamily: "Montserrat",
                    //       fontSize: 16),
                    //   decoration: TextFormFeildDecoration(),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  if(imageFile==null)
                  _showChoiceDialog(context);
                  else {
                      if (_formKey.currentState!.validate()) {
                         var now = new DateTime.now();
                        ApiCall().CreatePost(id,now.toString(), captionController.text,imageFile,selectedValue, context);
                      }
                  }
                },
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: Text(
                      imageFile==null?"Add Post":"Post",
                      style: ThemeHelper().TextStyleMethod2(16, context,
                          FontWeight.bold, Theme.of(context).backgroundColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator())),
    );
  }

  Widget InterestList() {
    //widget function for city list
    List<Interest> InterestList = List<Interest>.from(data.map((i) {
      return Interest.fromJSON(i);
    })); //searilize citylist json data to object model.

    return DropdownButtonFormField(
        menuMaxHeight: 200,
        decoration: TextFormFeildDecoration(),
        // borderRadius: BorderRadius.all(Radius.circular(15)),
        // UnderlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(15)),
        //   borderSide: BorderSide(color: Palette.dimGrey, width: 4)),
        dropdownColor: Colors.white,
        hint: Text(
          selectedValue,
          style: ThemeHelper().TextStyleMethod2(
            16,
            context,
            FontWeight.bold,
            Palette.Black,
          ),
        ),
        isExpanded: true,
        items: InterestList.map((Interest) {
          return DropdownMenuItem(
            child: Text(
              Interest.name,
              style: ThemeHelper().TextStyleMethod2(
                16,
                context,
                FontWeight.bold,
                Palette.Black,
              ),
            ),
            value: Interest.name,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value.toString();
          });
          print("Selected city is $value");
        });
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

