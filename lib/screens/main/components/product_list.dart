import 'package:card_swiper/card_swiper.dart';
import 'package:dns/app_properties.dart';
import 'package:dns/models/bannerModel.dart';
import 'package:dns/models/product.dart';
import 'package:dns/screens/product/product_page.dart';
import 'package:flutter/material.dart';

class BannerList extends StatelessWidget {
  List<BannerModel>? banners;

  final SwiperController swiperController = SwiperController();

  BannerList({required this.banners});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 5;
    double cardWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: cardHeight,
      child: Swiper(
        itemCount: banners!.length,
        itemBuilder: (_, index) {
          return BannerCard(
              height: cardHeight, width: cardWidth, banner: banners![index]);
        },
        scale: 0.8,
        controller: swiperController,
        viewportFraction: 0.7,
        loop: true,
        autoplay: true,
        fade: 0.5,
        pagination: SwiperCustomPagination(
          builder: (context, config) {
            if (config.itemCount > 20) {
              print(
                  "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
            }
            Color activeColor = mediumYellow;
            Color color = Colors.grey.withOpacity(.3);
            double size = 10.0;
            double space = 5.0;

            if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                config.layout == SwiperLayout.DEFAULT) {
              return new PageIndicator(
                count: config.itemCount,
                controller: config.pageController!,
                layout: config.indicatorLayout,
                size: size,
                activeColor: activeColor,
                color: color,
                space: space,
              );
            }

            List<Widget> dots = [];

            int itemCount = config.itemCount;
            int? activeIndex = config.activeIndex;

            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              dots.add(Container(
                key: Key("pagination_$i"),
                margin: EdgeInsets.all(space),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? activeColor : color,
                    ),
                    width: size,
                    height: size,
                  ),
                ),
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: dots,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BannerCard extends StatelessWidget {
  final BannerModel? banner;
  final double? height;
  final double? width;

  const BannerCard({
    required this.banner,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context).push(
      //     MaterialPageRoute(builder: (_) => ProductPage(product: product))),
      child: Stack(
        children: <Widget>[
          Container(
            // margin: const EdgeInsets.only(left: 30),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: mediumYellow,
            ),
            child: Column(
              children: <Widget>[
                // Align(
                //     alignment: Alignment.topLeft,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         product.name,
                //         style: TextStyle(color: Colors.white, fontSize: 16.0),
                //       ),
                //     )),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Container(
                //     // margin: const EdgeInsets.only(bottom: 12.0),
                //     // padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(10),
                //           bottomLeft: Radius.circular(10)),
                //       color: Color.fromRGBO(224, 69, 10, 1),
                //     ),
                //     child: Text(
                //       '\$${product.price}',
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Positioned(
          //   child: Hero(
          //     tag: product.image,
          //     child:
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // color: Colors.green,
                  image: DecorationImage(
                      image: NetworkImage(banner!.bannerUrl!),
                      fit: BoxFit.fill))),
          // child:
          // Image.network(
          //   banner.bannerUrl!,
          //   height: height * 1.4,
          //   width: width * 1.4,
          //   fit: BoxFit.contain,
          // ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
