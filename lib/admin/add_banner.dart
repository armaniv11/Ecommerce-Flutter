import 'dart:io';

import 'package:dns/app_properties.dart';
import 'package:dns/custom_classes/custom_classes.dart';
import 'package:dns/custom_widgets/widgets.dart';
import 'package:dns/functions/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../custom_background.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({Key? key}) : super(key: key);

  @override
  _AddBannerState createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  TextEditingController titleController = TextEditingController();

  File? productImage1;

  bool isLoading = false;

  DatabaseService databaseService = DatabaseService();
  ImagePicker picker = ImagePicker();

  getImage() async {
    await Future.delayed(Duration(milliseconds: 500));
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    // setState(() {
    if (pickedFile != null) {
      productImage1 = File(pickedFile.path);
      return productImage1;
    }
  }

  saveBanner(imgname, imgalias) async {
    if (_formKey.currentState!.validate()) {
      print(imgname);
      String imgUrl = '';
      String pid = randomAlphaNumeric(6);
      setState(() {
        isLoading = true;
      });

      if (imgname != null) {
        final storageReference =
            FirebaseStorage.instance.ref().child("banners/$imgalias");

        final uploadTask = storageReference.putFile(imgname);
        final downloadUrl = await uploadTask.whenComplete(() => null);
        imgUrl = await downloadUrl.ref.getDownloadURL();
      }

      await databaseService
          .newBanner(imgUrl, titleController.text, pid)
          .then((value) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Success!"),
                  content: Text("Banner has been saved Successfully!"),
                ));
      });
      setState(() {
        isLoading = false;
      });
    }
    // print(profilepic);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(color: backgroundColor?.withOpacity(0.8)),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // backgroundColor: Colors.pink[800],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Add banner"),
              elevation: 0,
            ),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.red,
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customTextFormField(
                          titleController,
                          "Banner Title",
                          Icon(
                            FontAwesomeIcons.heading,
                            color: Colors.grey[900],
                            size: 16,
                          ),
                          validationEnabled: true),
                      InkWell(
                          onTap: () async {
                            productImage1 = await getImage();
                            setState(() {});
                          },
                          child: customButton("Select Banner Image")),
                      imgColumn(
                          productImage1, null, "Asd", 200.00, width * 0.95),
                      InkWell(
                          onTap: () {
                            saveBanner(productImage1, titleController.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: saveButton("Save Banner"),
                          )),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
