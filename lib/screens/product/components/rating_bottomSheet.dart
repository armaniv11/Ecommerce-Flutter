import 'package:dns/app_properties.dart';
import 'package:dns/models/product.dart';
import 'package:dns/models/productmodel.dart';
import 'package:dns/models/reviewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBottomSheet extends StatefulWidget {
  final List<ReviewModel>? reviews;
  final String? image;
  final String? productName;
  RatingBottomSheet({this.reviews, this.image, this.productName});
  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  double rating = 2.0;
  List<int> ratings = [2, 1, 5, 2, 4, 3];

  @override
  Widget build(BuildContext context) {
    widget.reviews!.forEach((element) {
      print(element.reviewDate);
    });
    return Container(
      padding: EdgeInsets.only(top: 12),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      child:
          // ListView(
          //   children: <Widget>[
          SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // padding: const EdgeInsets.all(8.0),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image!), fit: BoxFit.fill),
                  color: yellow,
                  // shape: BoxShape.rectangle,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(width: 8.0, color: Colors.white)
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
              child: Text(
                widget.productName!,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            widget.reviews!.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.center,
                        child: Center(
                            child: Text(
                          'No Reviews Found !!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Recent Reviews')),
                  ),
            ...widget.reviews!
                .map((val) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          // margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: CircleAvatar(
                                  maxRadius: 14,
                                  backgroundImage:
                                      AssetImage('assets/background.jpg'),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          val.reviewBy ?? "Anonymous",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          val.reviewDate ?? "",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: RatingBar(
                                        ignoreGestures: true,
                                        itemSize: 16,
                                        allowHalfRating: true,
                                        initialRating: val.rating!,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        ratingWidget: RatingWidget(
                                          empty: Icon(Icons.favorite_border,
                                              color: Color(0xffFF8993),
                                              size: 20),
                                          full: Icon(
                                            Icons.favorite,
                                            color: Color(0xffFF8993),
                                            size: 20,
                                          ),
                                          half: SizedBox(),
                                        ),
                                        onRatingUpdate: (value) {
                                          setState(() {
                                            print(value);
                                            rating = value;
                                          });
                                          print(value);
                                        },
                                      ),
                                    ),
                                    Text(
                                      val.review ?? "nothin",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
