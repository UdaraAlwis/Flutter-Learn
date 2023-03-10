import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bmi_calculator_app/components/botom_button.dart';
import 'package:flutter_bmi_calculator_app/components/icon_content.dart';
import 'package:flutter_bmi_calculator_app/components/reusable_card.dart';
import 'package:flutter_bmi_calculator_app/components/round_icon_button.dart';
import 'results_page.dart';
import 'package:flutter_bmi_calculator_app/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int selectedHeight = 180;
  int selectedWeight = 60;
  int selectedAge = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : KInactiveCardColor,
                    cardChild: IconContent(
                      iconData: FontAwesomeIcons.mars,
                      textValue: 'MALE',
                    ),
                    onTap: () {
                      setState(() {
                        this.selectedGender = Gender.male;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: selectedGender == Gender.female
                        ? kActiveCardColor
                        : KInactiveCardColor,
                    cardChild: IconContent(
                      iconData: FontAwesomeIcons.venus,
                      textValue: 'FEMALE',
                    ),
                    onTap: () {
                      setState(() {
                        this.selectedGender = Gender.female;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: KLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        selectedHeight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'CM',
                        style: KLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      thumbColor: Color(0xFFEB1555),
                      activeTrackColor: Colors.white,
                      overlayColor: Color(0x1fEB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: selectedHeight.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (newValue) {
                        setState(() {
                          selectedHeight = newValue.round();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: KLabelTextStyle,
                        ),
                        Text(
                          selectedWeight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              iconData: FontAwesomeIcons.minus,
                              onTap: () {
                                setState(() {
                                  selectedWeight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              iconData: FontAwesomeIcons.plus,
                              onTap: () {
                                setState(() {
                                  selectedWeight++;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: KLabelTextStyle,
                        ),
                        Text(
                          selectedAge.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              iconData: FontAwesomeIcons.minus,
                              onTap: () {
                                setState(() {
                                  selectedAge--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              iconData: FontAwesomeIcons.plus,
                              onTap: () {
                                setState(() {
                                  selectedAge++;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              if (selectedAge < 20) {
                showDialog(
                    context: context,
                    builder: (BuildContext buildContext) {
                      return AlertDialog(
                        backgroundColor: kActiveCardColor,
                        title: Text(
                          'Not in sufficient Age!',
                          style: kBodyTextStyle,
                        ),
                        content: Text(
                          "This BMI calculator is intended for use by individuals 20 years and older.",
                          style: KLabelTextStyle,
                        ),
                        actions: <Widget>[
                          MaterialButton(
                            height: 40.0,
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            minWidth: double.infinity,
                            color: KBottomContainerColor,
                            child: Text(
                              "CLOSE",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });

                return;
              }

              var calc = CalculatorBrain(
                height: this.selectedHeight,
                weight: this.selectedWeight,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
