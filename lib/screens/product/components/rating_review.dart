import 'package:dns/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingReviewBottomSheet extends StatefulWidget {
  final order;

  const RatingReviewBottomSheet({Key? key, this.order}) : super(key: key);
  @override
  _RatingReviewBottomSheetState createState() =>
      _RatingReviewBottomSheetState();
}

class _RatingReviewBottomSheetState extends State<RatingReviewBottomSheet> {
  double rating = 2.0;
  List<int> ratings = [2, 1, 5, 2, 4, 3];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 92,
              width: 92,
              decoration: BoxDecoration(
                  color: yellow,
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: shadow,
                  border: Border.all(width: 8.0, color: Colors.white)),
              child: Image.network(widget.order['productpic']),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
              child: Text(
                widget.order['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Center(
              child: RatingBar(
                //                      borderColor: Color(0xffFF8993),
                //                      fillColor: Color(0xffFF8993),
                // ignoreGestures: true,
                itemSize: 20,
                allowHalfRating: true,
                glowColor: Colors.black,
                initialRating: 1,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                  empty: Icon(Icons.favorite_border,
                      color: Color(0xffFF8993), size: 20),
                  full: Icon(
                    Icons.favorite,
                    color: Color(0xffFF8993),
                    size: 20,
                  ),
                  half: SizedBox(),
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                  print(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 12),
              child: Text(
                'Review ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    enabled: true,
                    maxLines: 2,
                    maxLength: 120,
                    // keyboardType: inputtype,
                    // controller: controller,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        // prefixIcon: icon,
                        // filled: true,
                        // isDense: false,
                        border: InputBorder.none),
                    onChanged: (val) {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
