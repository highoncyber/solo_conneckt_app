import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiCalling.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Views/Interests/index.dart';
import 'package:soloconneckt/Views/VerificationPage/index.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Widgets/ShowResponse.dart';

class ProfilePicture extends StatefulWidget {
  String name, slogan, profession, workat, image,profile;
  bool isedit;
  ProfilePicture(
      {required this.slogan,
      required this.name,
      required this.profession,
      required this.workat,
      required this.image,
      required this.isedit,
      required this.profile,
      key})
      : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String id = "";
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("user_id")!;
    String? islogin = prefs.getString("is_logged_in");
    setState(() {});
  }

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

  File? imageFile;
  final ImagePicker _picker = ImagePicker();

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

  @override
  void initState() {
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                    )),
                Text(
                  "Add your Profile pricture",
                  style: ThemeHelper().TextStyleMethod2(
                      18, context, FontWeight.w600, Colors.black),
                ),
                Text(
                  "Profile",
                  style: ThemeHelper().TextStyleMethod2(
                      18, context, FontWeight.w600, Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: imageFile != null
                        ? DecorationImage(
                            image: FileImage(
                              imageFile!,
                            ),
                            fit: BoxFit.cover)
                        : null,
                    shape: BoxShape.circle,
                    border: Border.all(width: 5, color: Colors.white),
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
                      ? widget.image == ""
                          ? Icon(
                              Icons.person,
                              color: Colors.grey.shade300,
                              size: 70.0,
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      scale: 2,
                                      image: NetworkImage(imageUrlUser +
                                          widget.image.toString()))),
                            )
                      : Container(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(60, 60, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.grey.shade700,
                        size: 30.0,
                      ),
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Add your profile Picture",
              style: ThemeHelper()
                  .TextStyleMethod2(16, context, FontWeight.w600, Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (imageFile != null) {
                  ApiCall().RegisterForex(
                      widget.name,
                      widget.slogan,
                      widget.profession,
                      widget.workat,
                      imageFile,
                      context,
                      widget.profile,
                      id,
                      widget.isedit,
                      imageFile?.path.split('/').last,
                      false);
                } else {
                  ApiCall().RegisterForex(
                      widget.name,
                      widget.slogan,
                      widget.profession,
                      widget.workat,
                      widget.image,
                      context,
                      widget.profile,
                      id,
                      widget.isedit,
                      widget.image,
                      true);
                }
                // if (imageFile != null) {
                //   ApiCall().RegisterForex(
                //       widget.name,
                //       widget.slogan,
                //       widget.profession,
                //       widget.workat,
                //       imageFile,
                //       context,
                //       "ForexProfile",
                //       id,
                //       widget.isedit);
                // } else {
                //   ShowResponse("Please select an image.", context);
                // }
              },
              child: Container(
                height: 58,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Text(
                    "Next",
                    style: ThemeHelper().TextStyleMethod2(
                        16, context, FontWeight.bold, Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
