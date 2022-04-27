import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressHUDIndicator extends StatelessWidget {
  static String routeName = "/progressHuD_Indicator";
  final Widget child;
  final bool inAsyncCall;
  final bool inAsyncTitle;
  final double opacity;
  final Color color;
  //final Animation<Color> valueColor;

  ProgressHUDIndicator({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    required this.inAsyncTitle,
    this.opacity = 0.3,
    this.color = Colors.grey,
    //this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      // final modal = SpinKitSpinningLines(
      //   color: kPrimaryColor,
      //   size: 200,
      // );
      //SpinKitCircle
      // final modal = SpinKitPouringHourGlassRefined(
      //   color: Color(0xFFB2DFDC),
      //   size: 200,
      // );
      final modal = Center(
          child: SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                children: [
                  Opacity(
                    opacity: opacity,
                    child: ModalBarrier(dismissible: false, color: color),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: SpinKitPouringHourGlassRefined(
                        color: Color(0xFFB2DFDC),
                        size: 160,
                      )),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        inAsyncTitle
                            ? "Phát hiện cây trồng..."
                            : "Phát hiện bệnh tiềm năng",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      )
                    ],
                  ),
                ],
              )));
      widgetList.add(modal);
    }
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: widgetList,
      ),
    );
  }
}
