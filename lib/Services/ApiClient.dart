import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/Profile/index.dart';
import 'package:soloconneckt/Views/RealEstateProfile/RealEstateProfile/index.dart';
import 'package:soloconneckt/Views/phoneNumber/index.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/classes/post.dart';

import '../Views/ForexProfile/pages/Porfolio.dart';
import '../Views/ForexProfile/pages/index.dart';
import '../Views/Interests/index.dart';
import '../Views/SignUp/index.dart';

class HttpService {
  Future Login(
      String user_email, String user_passowrd, context, String Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var url;
    url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.post(url, body: {
      "email": "$user_email",
      "password": "$user_passowrd",
      "auth_key": auth_key
    });

    // await dialog.hide();
    // ShowResponse(response.body,context);
    var data = json.decode(response.body);

    var code = data[0]['code'];

    if (code == 0) {
      await dialog.hide();
      ShowResponse("Invalid Credetials", context);
    } else if (code == 1) {
      await dialog.hide();
      ShowResponse("Login Successfully", context);
      addStringToSF(data);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NewsFeed()),
          (route) => false);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  // Future register(name, email, number, password, imageFile, interest, context,
  //     Url, isedit, user_id) async {
  //   print(interest);
  //   ProgressDialog dialog = new ProgressDialog(context);
  //   dialog.style(message: 'Please wait...');
  //   var pic;
  //   var url;
  //   await dialog.show();
  //   try {
  //     url = Uri.parse(base_url + Url);
  //     var request = http.MultipartRequest('POST', url);
  //     print(url);
  //     if (imageFile != null) {
  //       request.fields['has_image'] = "true";
  //       pic = await http.MultipartFile.fromPath(
  //           "image", File(imageFile!.path).path);
  //       request.files.add(pic);
  //       print("object");
  //     } else {
  //       request.fields['has_image'] = "false";
  //       // request.fields["image"] = userimage;
  //     }

  //     request.fields['user_name'] = name;
  //     request.fields['user_email'] = email;
  //     request.fields['user_password'] = password;
  //     // request.fields['interest'] = interest;
  //     request.fields['phone'] = number;
  //     request.fields['auth_key'] = auth_key;
  //     if (isedit) request.fields['user_id'] = user_id;

  //     var response = await request.send().then((result) async {
  //       http.Response.fromStream(result).then((response) async {
  //         // ShowResponse(response.body);
  //         var data = json.decode(response.body);
  //         var code = data[0]['code'];
  //         if (code == 1) {
  //           await dialog.hide();
  //           if (isedit) {
  //             SharedPreferences preferences =
  //                 await SharedPreferences.getInstance();
  //             await preferences.clear();

  //             //update shared preff
  //             // SharedPreferences prefs = await SharedPreferences.getInstance();
  //             // prefs.setString('user_id', user_id);
  //             // prefs.setString('user_name', name);
  //             // prefs.setString('phone', number);
  //             // prefs.setString('user_email', email);
  //             // prefs.setString('user_password', password);
  //             // prefs.setString('is_logged_in', 'yes');
  //             // prefs.setString('image', data[0]['image']);
  //             // shred.user_id.value = prefs.getString("is_logged_in")!;
  //             ShowResponse("Updated successfully", context);
  //           } else {
  //             ShowResponse("Registered", context);
  //           }
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => SignUp()),
  //               (route) => false);
  //         } else if (code == 0) {
  //           await dialog.hide();
  //           ShowResponse("Email already registered", context);
  //         } else if (code == 3) {
  //           // print("3");
  //           await dialog.hide();
  //           ShowResponse(response.body, context);
  //         } else {
  //           await dialog.hide();
  //           ShowResponse("Some Error Occured. Contact Support", context);
  //         }
  //       });
  //     });
  //   } catch (e) {
  //     print("error" + e.toString());
  //   }
  // }

  Future register(name, email, number, password, imageFile, interest, context,
      Url, isedit, user_id, hasimage, imagename) async {
    print(json.encode(interest));
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var pic;
    var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);
      if (imageFile != null && hasimage == false) {
        request.fields['has_image'] = "true";
        pic = await http.MultipartFile.fromPath(
            "image", File(imageFile!.path).path);
        request.files.add(pic);
        print("object");
      } else {
        request.fields['has_image'] = "false";
        // request.fields["image"] = userimage;
      }

      request.fields['user_name'] = name;
      request.fields['user_email'] = email;
      request.fields['user_password'] = password;
      request.fields['interest'] = json.encode(interest);
      request.fields['phone'] = number;
      request.fields['auth_key'] = auth_key;
      if (isedit) request.fields['user_id'] = user_id;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body);
          var data = json.decode(response.body);
          // ShowResponse(response.body, context);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            if (isedit) {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();

              //update shared preff
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('user_id', user_id);
              prefs.setString('user_name', name);
              prefs.setString('phone', number);
              prefs.setString('user_email', email);
              prefs.setString('user_password', password);
              prefs.setString('is_logged_in', 'yes');
              if (hasimage == true) {
                prefs.setString('image', imagename);
              } else {
                prefs.setString('image', imagename);
              }
              // shred.user_id.value = prefs.getString("is_logged_in")!;
              ShowResponse("Update successfully", context);
            } else {
              ShowResponse("Registered", context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignUp()),
                  (route) => false);
            }
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse(response.body, context);
          } else if (code == 3) {
            print("3");
            await dialog.hide();
            ShowResponse("Email has already registered", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future updateUserInterest(
    user_id,
    interest,
    context,
    Url,
  ) async {
    // print("user post");
    // print(user_id);
    // print(post_id);
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['id'] = user_id;
      request.fields['interest'] = json.encode(interest);
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            ShowResponse("Updated", context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => NewsFeed()),
                (route) => false);
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future registerForex(name, slogan, profession, workAt, imageFile, profiletype,
      context, Url, isedit, user_id, hasimage, imagename) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var pic;
    var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);
      if (imageFile != null && hasimage == false) {
        request.fields['has_image'] = "true";
        pic = await http.MultipartFile.fromPath(
            "image", File(imageFile!.path).path);
        request.files.add(pic);
        print("object");
      } else {
        request.fields['has_image'] = "false";
        // request.fields["image"] = userimage;
      }

      request.fields['profile_name'] = name;
      request.fields['profile_slogan'] = slogan;
      request.fields['profession'] = profession;
      request.fields['profile_type'] = profiletype;
      request.fields['worksAt'] = workAt;
      request.fields['user_id'] = user_id;
      request.fields['auth_key'] = auth_key;
      if (isedit) request.fields['user_id'] = user_id;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body);
          var data = json.decode(response.body);
          // ShowResponse(response.body, context);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Submitted", context);

            if (profiletype == "RealProfile") {
              final RouteResponse = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RealProfileHome()),
              );
              if (RouteResponse == "refresh") {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => NewsFeed()),
                    (route) => false);
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => RealProfileHome()),
              // );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForexProfileHome()),
              );
            }
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse(response.body, context);
          } else if (code == 3) {
            print("3");
            await dialog.hide();
            ShowResponse("Email has already registered", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future NewPost(
      user_id, datetime, caption, imageFile, interest, context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var pic;
    var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);
      request.fields['has_image'] = "true";
      pic = await http.MultipartFile.fromPath(
          "image", File(imageFile!.path).path);
      request.files.add(pic);

      request.fields['user_id'] = user_id;
      request.fields['interest'] = interest;
      request.fields['datetime'] = datetime;
      request.fields['caption'] = caption;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Post uploaded", context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsFeed()),
            );
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future NewPortfolio(user_id, profile_type, imageFile, context, Url) async {
    print(user_id);
    print(profile_type);
    print(imageFile);
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var pic;
    var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);
      // request.fields['has_image'] = "true";
      pic = await http.MultipartFile.fromPath(
          "image", File(imageFile!.path).path);
      request.files.add(pic);

      request.fields['user_id'] = user_id;
      request.fields['profile_type'] = profile_type;
      // request.fields['caption'] = caption;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Image uploaded", context);
            if (profile_type == "RealProfile") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RealProfileHome()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForexProfileHome()),
              );
            }
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse(response.body, context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future NewStory(
      user_id, datetime, caption, imageFile, isVedio, context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var pic;
    var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);
      request.fields['has_image'] = "true";
      pic = await http.MultipartFile.fromPath(
          "image", File(imageFile!.path).path);
      request.files.add(pic);

      request.fields['user_id'] = user_id;
      request.fields['isVedio'] = isVedio;
      // request.fields['caption'] = caption;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context); await dialog.hide();
          // ShowResponse(response.body, context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Added successfully", context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsFeed()),
            );
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future NewTopic(
    user_id,
    datetime,
    name,
    imageFile,
    context,
    Url,
  ) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var pic;
    var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);
      request.fields['has_image'] = "true";
      pic = await http.MultipartFile.fromPath(
          "image", File(imageFile!.path).path);
      request.files.add(pic);

      request.fields['user_id'] = user_id;
      request.fields['datetime'] = datetime;
      request.fields['name'] = name;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Added successfully", context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsFeed()),
            );
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  deleteSavedPost(user_id, post_id, context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      ShowResponse("Unsaved From Collections", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  deleteGroupChat(user_id, context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      ShowResponse("Deleted", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  deletePortfolio(context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      ShowResponse("Deleted", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  deletePost(context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      ShowResponse("Delete From Post", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  UnblockUser(context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      ShowResponse("Un blocked Successfully", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  reportPost(context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      ShowResponse("Report Successfully", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  Future SavedPost(
    user_id,
    post_id,
    context,
    Url,
  ) async {
    // print("user post");
    // print(user_id);
    // print(post_id);
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['user_id'] = user_id;
      request.fields['post_id'] = post_id;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            ShowResponse("Save To Collections", context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const MainPage()),
            // );
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future BlockUser(
    user_id,
    profileId,
    context,
    Url,
  ) async {
    var url;
    // await dialog.show();
    try {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(message: 'Please wait...');
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['blockList_first_user_id'] = user_id;
      request.fields['blockList_second_user_id'] = profileId;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Blocked Successfully", context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const MainPage()),
            // );
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while blocking", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while blocking", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  delete(context, Url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url = Uri.parse(base_url + Url);
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);

    if (JsonData[0]["code"] == 1) {
      await dialog.hide();
      // ShowResponse("Unsaved From Collections", context);
    } else {
      await dialog.hide();
      ShowResponse("Some Error Occured. Contact Support", context);
    }
  }

  Future LikedPost(
    user_id,
    post_id,
    context,
    Url,
  ) async {
    // print("user post");
    // print(user_id);
    print(post_id);
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + Url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['user_id'] = user_id;
      request.fields['post_id'] = post_id;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            // ShowResponse("Save To Collections", context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const MainPage()),
            // );
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future sendMail(receiver, subject, message, context) async {
    var url = Uri.parse(
        "https://fypassad.highoncyber.com/send_mail.php?receiver=$receiver&subject=$subject&message=$message");
    // var Users=await http.get(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData);
    var code = JsonData[0]['code'];
    if (code == 1) {
      ShowResponse("Optp Sent", context);
    } else if (code == 0) {
      ShowResponse("Something went wrong.Tap on resent.", context);
    }
  }

// personal profile

  Future InsertAppLink(
    user_id,
    title,
    cardurl,
    icon,
    profile_type,
    context,
    url,
  ) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    // var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['user_id'] = user_id;
      request.fields['title'] = title;
      request.fields['url'] = cardurl;
      request.fields['profile_type'] = profile_type;
      request.fields['icon'] = icon;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Added", context);
            Navigator.pop(context);
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future InsertConnection(
    user_id,
    title,
    cardurl,
    icon,
    profile_type,
    context,
    url,
  ) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    // var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['user_id'] = user_id;
      request.fields['title'] = title;
      request.fields['url'] = cardurl;
      request.fields['profile_type'] = profile_type;
      request.fields['icon'] = icon;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Added", context);
            Navigator.pop(context);
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future MoveToConnections(id, context, url) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    // var url;
    await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['id'] = id;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Added", context);
            Navigator.pop(context);
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future editActiveStatus(user_id, ActiveProfile, context, url) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['ActiveProfile'] = ActiveProfile;
      request.fields['user_id'] = user_id;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            // ShowResponse("Added", context);
            // Navigator.pop(context);
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future addToExchangeAndConnection(userid, exchangeId, context, url) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['sender_id'] = userid;
      request.fields['receiver_id'] = exchangeId;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            ShowResponse("Added", context);
            // Navigator.pop(context);
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse(response.body, context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future UpdateActiveInactiveStatus(
    card_id,
    active,
    profile_type,
    context,
    url,
  ) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['id'] = card_id;
      request.fields['active'] = active;
      request.fields['profile_type'] = profile_type;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            // ShowResponse("Updating", context);
            // Navigator.pop(context);
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future UpdateCardOrder(
    card_id,
    order,
    profile_type,
    context,
    url,
  ) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['id'] = card_id;
      request.fields['order'] = order;
      request.fields['profile_type'] = profile_type;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            // ShowResponse("Added Successfully", context);
            // Navigator.pop(context);
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future ActivateCard(
    user_id,
    serial,
    context,
    url,
  ) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    var url2;
    await dialog.show();
   
    try {
      url2 = Uri.parse(base_url + url);
   
      var request = http.MultipartRequest('POST', url2);
      
     print(url2);
      request.fields['user_id'] = user_id;
      request.fields['serial'] = serial.toString();
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body, context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            await dialog.hide();
            ShowResponse("Activated Successfully", context);
            // Navigator.pop(context);
          } else if (code == 0) {
            await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 2) {
            await dialog.hide();
            ShowResponse("Already Activated", context);
          } else {
            await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
       await dialog.hide();
      print("error" + e.toString());
    }
  }

  Future UpdateActiveProfile(
    user_id,
    profile_type,
    context,
    url,
  ) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // var url;
    // await dialog.show();
    try {
      url = Uri.parse(base_url + url);
      var request = http.MultipartRequest('POST', url);
      print(url);

      request.fields['user_id'] = user_id;
      request.fields['activeProfile'] = profile_type;
      request.fields['auth_key'] = auth_key;

      var response = await request.send().then((result) async {
        http.Response.fromStream(result).then((response) async {
          // ShowResponse(response.body,context);
          var data = json.decode(response.body);
          var code = data[0]['code'];
          if (code == 1) {
            // await dialog.hide();
            // ShowResponse("Added Successfully", context);
            // Navigator.pop(context);
          } else if (code == 0) {
            // await dialog.hide();
            ShowResponse("Error while inserting", context);
          } else if (code == 3) {
            // await dialog.hide();
            ShowResponse("Error while uploading", context);
          } else {
            // await dialog.hide();
            ShowResponse("Some Error Occured. Contact Support", context);
          }
        });
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }
}

addStringToSF(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_id', data[0]['user_id']);
  prefs.setString('user_name', data[0]['user_name']);
  prefs.setString('phone', data[0]['phone']);
  // prefs.setString('father_name', data[0]['father_name']);
  prefs.setString('interest', data[0]['interest']);
  // prefs.setString('phone', data[0]['phone']);
  prefs.setString('user_email', data[0]['user_email']);
  // prefs.setString('country', data[0]['country']);
  // prefs.setString('state', data[0]['state']);
  // prefs.setString('city', data[0]['city']);
  // prefs.setString('dob', data[0]['dob']);
  // prefs.setString('gender', data[0]['gender']);
  prefs.setString('user_password', data[0]['user_password']);
  prefs.setString('is_logged_in', 'yes');
  prefs.setString('image', data[0]['image']);
  // Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (context) => bottomNavBar()),
  //     (route) => false);
  print(prefs.getString("is_logged_in"));
  print(prefs.getString("user_name"));
  print(prefs.getString("user_email"));
}
