import 'package:project_detect_disease_datn/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: getProportionateScreenHeight(60),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
                elevation: 0,
                primary: Colors.white,
                backgroundColor: color,
                //side: BorderSide(width: 2, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                //padding: EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(350, 40)),

            //color: kPrimaryColor,
            onPressed: press,
            child: Text(
              text!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
