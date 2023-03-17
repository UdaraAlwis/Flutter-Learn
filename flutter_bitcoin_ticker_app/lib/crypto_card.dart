import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {super.key,
      required this.cryptoCurrency,
      required this.fiatCurrency,
      required this.fiatCurrencyValue});

  final String cryptoCurrency;
  final String fiatCurrency;
  final String fiatCurrencyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency : $fiatCurrencyValue $fiatCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
