import 'package:dns/models/category.dart';
import 'package:flutter/material.dart';

class EachTag extends StatefulWidget {
  final Category categoryName;
  final String active;
  final ValueChanged<String> callBack;
  const EachTag(
      {Key? key,
      required this.categoryName,
      required this.active,
      required this.callBack})
      : super(key: key);

  @override
  _EachTagState createState() => _EachTagState();
}

class _EachTagState extends State<EachTag> {
  bool changeColor = false;

  Color activeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    String activew = widget.active;

    print("${widget.active} printing active");
    print("${widget.categoryName.category} printing catgory name");
    return InkWell(
      onTap: () {
        setState(() {
          // changeColor = !changeColor;
          // // activeColor = Colors.yellow;
          // print(activew);
          activew = widget.categoryName.category;
          widget.active == widget.categoryName.category
              ? activeColor = Colors.yellow
              : activeColor = Colors.white;
          widget.callBack(widget.categoryName.category);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: activeColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.categoryName.category),
          ),
        ),
      ),
    );
  }
}
