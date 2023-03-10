import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator_app/constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({@required this.buttonTitle, this.onTap});

  final String buttonTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            this.buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: KBottomContainerColor,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: KBottomContainerHeight,
        padding: EdgeInsets.only(bottom: 20.0),
      ),
    );
  }
}
