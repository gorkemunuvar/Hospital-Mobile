import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MySlider extends StatefulWidget {
  final List<Widget> images;
  final double height;
  final bool enlargeCenterPage;

  MySlider(this.images, this.height, {this.enlargeCenterPage = false});

  @override
  State<StatefulWidget> createState() {
    return _MySliderState();
  }
}

class _MySliderState extends State<MySlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Slider
      CarouselSlider(
        items: widget.images,
        options: CarouselOptions(
            height: widget.height,
            aspectRatio: 2.0,
            enlargeCenterPage: widget.enlargeCenterPage,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      // Current selected circles
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.images.asMap().entries.map((entry) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          );
        }).toList(),
      ),
    ]);
  }
}
