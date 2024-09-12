import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../generated/assets.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({Key? key}) : super(key: key);

  @override
  _BannerSectionState createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 200,
            child: PageView(
              controller: _pageController,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(Assets.imagesImg1, fit: BoxFit.cover,),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(Assets.imagesImg2, fit: BoxFit.cover,),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(Assets.imagesImg3, fit: BoxFit.cover,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.black,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
