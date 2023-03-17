import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedFiatCurrency = 'USD';
  List<Widget> cryptoExchangeRateWidgets = [];

  DropdownButton<String> getDropdownButton() {
    var dropDownItems = <DropdownMenuItem<String>>[];

    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedFiatCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          setState(() {
            selectedFiatCurrency = value!;
            print('User selected currency $selectedFiatCurrency');
          });

          getExchangeRateValue();
        });
      },
    );
  }

  CupertinoPicker getiOSPicker() {
    var dropDownItems = <Text>[];
    for (var currency in currenciesList) {
      dropDownItems.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedFiatCurrency = currenciesList[selectedIndex];
          print('User selected currency $selectedFiatCurrency');
        });

        getExchangeRateValue();
      },
      children: dropDownItems,
    );
  }

  void getExchangeRateValue() async {
    CoinData coinData = CoinData();
    Map<String, String> cryptoExchangeRates = <String, String>{};

    for (var cryptoCoin in cryptoList) {
      var results = await coinData.getExchangeRate(
        cryptoCoin,
        selectedFiatCurrency,
      );
      cryptoExchangeRates.addAll({cryptoCoin: results});
    }

    setState(() {
      cryptoExchangeRateWidgets.clear();
      cryptoExchangeRates.forEach((key, value) {
        cryptoExchangeRateWidgets.add(
          CryptoCard(
              cryptoCurrency: key,
              fiatCurrency: selectedFiatCurrency,
              fiatCurrencyValue: value),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getExchangeRateValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoExchangeRateWidgets,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getiOSPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
