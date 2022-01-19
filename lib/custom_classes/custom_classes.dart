import 'package:dns/models/category.dart';
import 'package:dns/screens/gallery/product_categories.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final Category? category;
  const CategoriesList({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductCategoryPage(
                      category: category,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: category!.category,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(category!.image), fit: BoxFit.fill),
                  gradient: LinearGradient(
                      colors: [category!.begin, category!.end],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
              ),
            ),
            Text(category!.category)
          ],
        ),
      ),
    );
  }
}

class CustomHeaderWithView extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;

  const CustomHeaderWithView(
      {Key? key, required this.text1, required this.text2, required this.text3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(8),
              child: Text(
                text1!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              )),
          Text(
            text2!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[800]),
          ),
          Spacer(),
          text3 == ""
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(236, 60, 3, 1),
                            Color.fromRGBO(234, 60, 3, 1),
                            Color.fromRGBO(216, 78, 16, 1),
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                          offset: Offset(0, 5),
                          blurRadius: 10.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(9.0)),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    text3!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  )),
        ],
      ),
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  final String? text;
  final bool? option;
  final ValueChanged<bool> callBack;
  const CustomCheckBox(
      {Key? key,
      required this.text,
      required this.option,
      required this.callBack})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    bool? opt1 = widget.option;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 12,
                    letterSpacing: 3),
              ),
              Checkbox(
                  value: opt1,
                  onChanged: (val) {
                    print(widget.text);
                    print(val);
                    widget.callBack(val!);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {
  final String? heading;
  final List? items;
  final String? selected;
  final ValueChanged<String> callBack;
  final Color color;

  const CustomDropDown(
      {Key? key,
      required this.heading,
      required this.items,
      required this.callBack,
      required this.selected,
      this.color = Colors.yellow})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    String? _selected = widget.selected;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.heading == ''
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.heading!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: widget.color),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
          Material(
            type: MaterialType.canvas,
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton(
                hint: Text("Please select an option!!"),
                underline: SizedBox(),
                onChanged: (dynamic val) {
                  setState(() {
                    _selected = val;
                    print(val);
                    widget.callBack(_selected!);
                    // _selectedCare = val.toString();
                  });
                },
                isExpanded: true,
                iconEnabledColor: Colors.blue[800],
                dropdownColor: Colors.grey[100],
                style: TextStyle(
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
                value: _selected,
                items: widget.items!.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
