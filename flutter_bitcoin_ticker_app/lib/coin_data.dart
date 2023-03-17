import 'package:flutter_bitcoin_ticker_app/network_helper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apiKey = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX';
const String coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<String> getExchangeRate(String cryptoCoin, fiatCurrency) async {
    String url = '$coinApiUrl/$cryptoCoin/$fiatCurrency';
    var networkHelper = NetworkHelper(url: url, apiKey: apiKey);
    var exchangeData = await networkHelper.getData();

    if (exchangeData != null) {
      double rateValue = exchangeData['rate'];
      return rateValue.toStringAsFixed(0);
    }

    return '?';
  }
}
