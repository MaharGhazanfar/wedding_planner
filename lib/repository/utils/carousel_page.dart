import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';


class CarouselImagesPage extends StatefulWidget {
  const CarouselImagesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselImagesPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = DataList.listImages
        .map((item) => Image.asset(item, fit: BoxFit.fill, width: 1000.0))
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              viewportFraction: .99,
              autoPlayAnimationDuration: const Duration(milliseconds: 700),
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.015,
          left: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: DataList.listImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
