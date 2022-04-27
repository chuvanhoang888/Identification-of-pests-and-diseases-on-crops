import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  //final Animation<Color> valueColor;

  ProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    //this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Center(
          child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Opacity(
                    opacity: opacity,
                    child: ModalBarrier(dismissible: false, color: color),
                  ),
                  Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  )),
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
