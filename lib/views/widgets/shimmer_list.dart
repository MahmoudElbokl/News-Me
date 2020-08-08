import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int time = 400;
    double containerWidth = size.width * 0.6;
    double containerHeight = size.height * 0.025;
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
                    // shimmer header
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
                // shimmer articles
                    : Container(
                  margin: EdgeInsets.symmetric(
                      vertical:
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.15,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        color: Colors.grey,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: containerHeight,
                            width: containerWidth,
                            color: Colors.grey,
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.01),
                          Container(
                            height: containerHeight,
                            width: containerWidth,
                            color: Colors.grey,
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.01),
                          Container(
                            height: containerHeight,
                            width: containerWidth * 0.75,
                            color: Colors.grey,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}
