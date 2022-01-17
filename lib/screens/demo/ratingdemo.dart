import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDemo extends StatefulWidget {
  const RatingDemo({Key? key}) : super(key: key);

  @override
  _RatingDemoState createState() => _RatingDemoState();
}

class _RatingDemoState extends State<RatingDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          child: RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.favorite,
              color: Colors.orange,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          )),
    );
  }
}
