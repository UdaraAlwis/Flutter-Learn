import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.url, required this.apiKey});

  final String url;
  final String apiKey;

  Future getData() async {
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      "X-CoinAPI-Key": apiKey,
    });

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
