import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostView extends StatelessWidget {
  const ShimmerPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 100.0,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          Container(
            width: double.infinity,
            height: 100.0,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          Container(
            width: double.infinity,
            height: 100.0,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
