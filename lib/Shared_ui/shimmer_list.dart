import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:news_me/Shared_ui/shimmer_layout.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      )
                    : ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}
