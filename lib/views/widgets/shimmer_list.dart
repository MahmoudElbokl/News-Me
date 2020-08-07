import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news_me/views/widgets/shimmer_layout.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int time = 400;
    return SafeArea(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: (index == 0)
                    ? Container(
                        height: size.height * 0.25,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      )
                    : ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}