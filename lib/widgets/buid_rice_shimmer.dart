import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuidRiceShimmer extends StatelessWidget {
  const BuidRiceShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      period: Duration(seconds: 3),
      child: Container(
        //decoration: BoxDecoration(color: Colors.white),
        height: 140,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 110,
                  height: 130,
                  decoration: BoxDecoration(color: Colors.grey[400]),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                height: 140,
                width: MediaQuery.of(context).size.width - 167,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 25.0,
                        decoration: BoxDecoration(color: Colors.grey[400])),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        decoration: BoxDecoration(color: Colors.grey[400])),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
