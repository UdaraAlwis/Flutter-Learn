import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator_app/constants.dart';

class IconContent extends StatelessWidget {
  IconContent({@required this.iconData, @required this.textValue});

  final IconData iconData;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          textValue,
          style: KLabelTextStyle,
        ),
      ],
    );
  }
}
