import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiCalling.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';

import '../../../../Widgets/IconList.dart';

class AddAppPage extends StatefulWidget {
  String title, icon, label,type;
  AddAppPage(
      {Key? key, required this.icon, required this.label, required this.title,required this.type})
      : super(key: key);

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}

class _AddAppPageState extends State<AddAppPage> {
  
final nameController = new TextEditingController();
final _formKey = GlobalKey<FormState>();
  String id = "";

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/"+widget.icon,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.title,
                    style: ThemeHelper().TextStyleMethod2(
                        20,
                        context,
                        FontWeight.w600,
                        Theme.of(context).colorScheme.primaryVariant),
                  ),
                  SizedBox(
                    height:20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: ThemeHelper().TextStyleMethod2(
                            14, context, FontWeight.w500, Theme.of(context).colorScheme.primaryVariant),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value != null && value.trim().length < 3) {
                          return 'This field requires a minimum of 3 characters';
                        }

                        return null;
                      },
                      style: ThemeHelper().TextStyleMethod2(
                          16, context, FontWeight.bold, Palette.Black),
                      decoration: TextFormFeildDecoration(),
                    ),
                  ),
                  // Spacer(),
                   SizedBox(
                    height: 155,
                  ),
                   InkWell(
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                      HttpService().InsertAppLink(id,widget.title,nameController.text,widget.icon,widget.type,context,ApiUrl.insertCard);
                    }
                    },
                     child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      borderRadius: const BorderRadius.all(Radius.circular(35))),
                child: Center(
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "+ Add",
                            style: ThemeHelper().TextStyleMethod2(
                              16,
                                context,
                                FontWeight.w500,
                                Theme.of(context).backgroundColor),
                          ),
                        ]),
                ),
              ),
                   ),

                ]),
          ),
        ),
      ),
      
    );
  }
}
