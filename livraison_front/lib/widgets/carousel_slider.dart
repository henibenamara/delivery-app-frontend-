
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/**class Sliderimages extends StatefulWidget {
  Sliderimages({Key? key}) : super(key: key);

  @override
  State<Sliderimages> createState() => _SliderimagesState();
}

class _SliderimagesState extends State<Sliderimages> {
  final urlImages = [
    'lib/Assets/img/carousel_first.png',
    'lib/Assets/img/carousel 2.png',
    'lib/Assets/img/carousel last.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child:CarouselSlider.builder(
        itemCount: urlImages.length,
        itemBuilder: (context,index,realIndex) {
          final  urlImage = urlImages[index];

          return buildImage(urlImage, index);
        },
        options: CarouselOptions(
          autoPlay: false,
          viewportFraction: 1,
          height: MediaQuery.of(context).size.height / 5.1,
        ),
      ),
    );
  }
}

Widget buildImage(String urlImage, index) => Container(
  margin: const EdgeInsets.symmetric(horizontal: 10),
  child: Image.asset(urlImage,fit: BoxFit.contain,),
);*/