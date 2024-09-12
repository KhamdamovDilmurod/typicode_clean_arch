import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserView extends StatelessWidget {
  const ShimmerUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
              ),
            );
          },
          scrollDirection: Axis.horizontal,

        ),
      ),
    );
  }
}
