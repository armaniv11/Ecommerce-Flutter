import 'dart:core';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns/app_properties.dart';
import 'package:dns/custom_functions/custom_functions.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:dns/screens/main/main_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? profilePic;
  String networkImage = '';
  bool isLoading = true;
  DatabaseService databaseService = DatabaseService();

  saveProfile(imgname, imgalias) async {
    print(imgname);
    String? imgUrl = '';
    String? pid = randomAlphaNumeric(6);
    setState(() {
      isLoading = true;
    });

    if (imgname != null) {
      final storageReference =
          FirebaseStorage.instance.ref().child("profile/$imgalias");

      final uploadTask = storageReference.putFile(imgname);
      final downloadUrl = await uploadTask.whenComplete(() => null);
      imgUrl = await downloadUrl.ref.getDownloadURL();
    }

    await databaseService
        .updateProfile(
            nameController.text,
            mobController.text,
            emailController.text,
            addressController.text,
            cityController.text,
            pincodeController.text,
            imgUrl)
        .then((value) {
      GetStorage().write('name', value);

      return AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          showCloseIcon: true,
          title: 'Success!!',
          desc: 'Profile has been saved successfully !',
          btnOkOnPress: () {
            debugPrint('OnClcik');
            // Navigator.of(context).pop();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: (type) {
            // Navigator.of(context).pop();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));

            // debugPrint('Dialog Dissmiss from callback $type');
          })
        ..show();
    });
  }

  bool bmale = true;
  bool bfemale = false;
  bool bother = false;
  String? gender = '';
  Widget genderTextFormField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              bother = false;
              bmale = true;
              bfemale = false;
              gender = 'male';
            });
          },
          child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  border: bmale
                      ? Border.all(color: Colors.redAccent, width: 3)
                      : Border.all(color: Colors.black, width: 1),
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage('assets/male.png')))),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              bother = false;
              bmale = false;
              bfemale = true;
              gender = 'female';
            });
          },
          child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  border: bfemale
                      ? Border.all(color: Colors.redAccent, width: 3)
                      : Border.all(color: Colors.black, width: 1),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/female.webp')))),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              bother = true;
              bmale = false;
              bfemale = false;
              gender = 'other';
            });
          },
          child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  border: bother
                      ? Border.all(color: Colors.redAccent, width: 3)
                      : Border.all(color: Colors.black, width: 1),
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage('assets/other.png')))),
        ),
      ],
    );
  }

  var profileInfo;
  GetStorage box = GetStorage();

  checkProfile() async {
    profileInfo = await databaseService.getInfo('Profile', box.read('mob'));
    mobController.text = box.read('mob') ?? "";
    if (profileInfo != null) {
      nameController.text = profileInfo['name'] ?? "";
      emailController.text = profileInfo['email'] ?? "";
      addressController.text = profileInfo['address'] ?? "";
      cityController.text = profileInfo['city'] ?? "";
      pincodeController.text = profileInfo['pincode'] ?? "";
      networkImage = profileInfo['profilepic'] ?? "";
      gender = profileInfo['gender'] == '' ? 'Male' : profileInfo['gender'];
    }

    setState(() {
      isLoading = false;
    });

    // print(profileInfo['createdat']);
  }

  @override
  void initState() {
    checkProfile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            title: Text("Profile"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: size.height / 3.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/background.png'),
                                fit: BoxFit.fill),
                            color: backgroundColor),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                              image: profilePic != null
                                  ? DecorationImage(
                                      image: FileImage(profilePic!),
                                      fit: BoxFit.fill)
                                  : networkImage == ""
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              "https://firebasestorage.googleapis.com/v0/b/dnss-3d340.appspot.com/o/icondonotdelete%2Fuser%20(1).png?alt=media&token=834df0ad-055b-4f73-a5cf-659a8387da91"))
                                      : DecorationImage(
                                          image: NetworkImage(networkImage))),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () async {
                                  String img = await customGetImage();
                                  if (img != "") {
                                    setState(() {
                                      print(img);
                                      profilePic = File(img);
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.pink,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  // height: 20,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // customText("Personal Details:"),
                      customTextFormFieldWithoutHeading(
                          nameController,
                          "Name *",
                          Icon(
                            Icons.person,
                            size: 20,
                            color: Colors.pink[200],
                          ),
                          headingColor: Colors.pink[200],
                          headingsize: 13),
                      customTextFormFieldWithoutHeading(
                          mobController,
                          "Mobile Number *",
                          Icon(
                            Icons.phone,
                            size: 20,
                            color: Colors.pink[200],
                          ),
                          headingColor: Colors.pink[200],
                          inputtype: TextInputType.phone,
                          headingsize: 13,
                          enabled: false),
                      customTextFormFieldWithoutHeading(
                        emailController,
                        "Email ID",
                        Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.pink[200],
                        ),
                        headingColor: Colors.pink[200],
                        inputtype: TextInputType.emailAddress,
                        headingsize: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 8, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gender *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[200]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      genderTextFormField(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: customTextFormFieldWithoutHeading(
                            addressController,
                            "Address",
                            Icon(
                              FontAwesomeIcons.mapMarked,
                              size: 20,
                              color: Colors.pink[200],
                            ),
                            headingColor: Colors.pink[200],
                            inputtype: TextInputType.multiline,
                            headingsize: 13,
                            maxlines: 5),
                      ),
                      customTextFormFieldWithoutHeading(
                          cityController,
                          "City",
                          Icon(
                            Icons.maps_home_work_outlined,
                            size: 20,
                            color: Colors.pink[200],
                          ),
                          headingColor: Colors.pink[200],
                          inputtype: TextInputType.name,
                          headingsize: 13),
                      customTextFormFieldWithoutHeading(
                          pincodeController,
                          "Pincode",
                          Icon(
                            Icons.pin_drop_outlined,
                            size: 20,
                            color: Colors.pink[200],
                          ),
                          headingColor: Colors.pink[200],
                          inputtype: TextInputType.number,
                          headingsize: 13),
                      InkWell(
                          onTap: () {
                            saveProfile(profilePic, box.read('mob'));
                          },
                          child: customButton("Save"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? SafeArea(
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
