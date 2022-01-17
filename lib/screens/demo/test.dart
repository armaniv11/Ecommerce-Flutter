import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Center(
              child: Text("This is home"),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Child(index)));
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          child: Text("item $index",
                              style: TextStyle(color: Colors.white))));
                }),
          ],
        ),
      ),
    );
  }
}

class Child extends StatelessWidget {
  final int index;
  Child(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Text("Child view $index"),
        ));
  }
}
