import 'package:dns/app_properties.dart';
import 'package:dns/screens/auth/confirm_otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'forgot_password_page.dart';

class RegisterPagePhone extends StatefulWidget {
  @override
  _RegisterPagePhoneState createState() => _RegisterPagePhoneState();
}

class _RegisterPagePhoneState extends State<RegisterPagePhone> {
  TextEditingController mobController = TextEditingController();

  TextEditingController password = TextEditingController(text: '12345678');

  TextEditingController cmfPassword = TextEditingController(text: '12345678');
  @override
  void initState() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    print(user);
    // print(user!.uid);
    print("checking");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Glad To Meet You',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ConfirmOtpPage(
                  phoneNo: mobController.text,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Material(
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(16),
            // width: MediaQuery.of(context).size.width / 2,
            // height: 80,
            child: Center(
                child: new Text("Confirm",
                    style: const TextStyle(
                        color: const Color(0xfffefefe),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0))),
            decoration: BoxDecoration(
                gradient: mainButton,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    offset: Offset(0, 5),
                    blurRadius: 10.0,
                  )
                ],
                borderRadius: BorderRadius.circular(9.0)),
          ),
        ),
      ),
    );

    Widget registerForm() {
      return Row(
        children: [
          Container(
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[50]!.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "+91",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
              )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50]!.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: TextField(
                controller: mobController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  hintText: 'Mobile Number',
                  // prefixIcon: Icon(Icons.phone),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(right: 20, top: 20, bottom: 20),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'Sign Up With ',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.google,
                  size: 34,
                ),
              ),
            )
          ],
        )
      ],
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                title,
                Spacer(),
                subTitle,
                Spacer(),
                registerForm(),
                registerButton,
                Spacer(flex: 1),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    radius: 26,
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
                Padding(
                    padding: EdgeInsets.only(bottom: 20), child: socialRegister)
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
