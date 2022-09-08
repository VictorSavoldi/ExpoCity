import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expocity/components/colors.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/manifestation/components/carousel_with_indicator.dart';
import 'package:flutter/material.dart';

class CarouselImages extends State<CarouselWithIndicator> {
  CarouselImages(this.manifestation);

  final Manifestation manifestation;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
          options: CarouselOptions(
              viewportFraction: manifestation.images.length > 1 ? 0.8 : 0.85,
              height: MediaQuery.of(context).size.height * 0.30,
              autoPlay: true,
              enableInfiniteScroll:
                  manifestation.images.length > 1 ? true : false,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 8),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: manifestation.images
              .map((item) => Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 5),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                                imageUrl: item,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: .0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black38,
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
                            ),
                          ],
                        )),
                  ))
              .toList()),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: manifestation.images.map((url) {
          int index = manifestation.images.indexOf(url);
          return manifestation.images.length > 1
              ? Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.only(top: 10, left: 2.5, right: 2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? defaultColor
                        : const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                )
              : Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.only(top: 10, left: 2.5, right: 2.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
        }).toList(),
      ),
    ]);
  }
}
