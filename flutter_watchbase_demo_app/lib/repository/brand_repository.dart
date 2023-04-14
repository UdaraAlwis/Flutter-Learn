import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:flutter_watchbase_demo_app/model/brand.dart';
import 'package:flutter_watchbase_demo_app/model/brand_family.dart';
import 'package:flutter_watchbase_demo_app/model/watch.dart';
import 'package:flutter_watchbase_demo_app/model/watch_details.dart';

class BrandRepository {
  final String _apiKey = 'b4pmcsmexego1c0lpk5hmeqw2bkhsqaiwzhuj9cy';
  final String _apiUrl = 'https://api.watchbase.com/v1';

  Future<List<Brand>> getBrands() async {
    var response = await http.get(Uri.parse("$_apiUrl/brands?format=json&key=$_apiKey"));

    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      return jsonData['brands'].map<Brand>((json) => Brand.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }

  Future<List<BrandFamily>> getFamilies(int brandId) async {
    var response = await http.get(Uri.parse("$_apiUrl/families?brand-id=$brandId&format=json&key=$_apiKey"));

    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      return jsonData['families'].map<BrandFamily>((json) => BrandFamily.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load families for brand: $brandId');
    }
  }

  Future<List<Watch>> getWatches(int brandId, int familyId) async {
    var response =
        await http.get(Uri.parse("$_apiUrl/watches?brand-id=$brandId&family-id=$familyId&format=json&key=$_apiKey"));
    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      return jsonData['watches'].map<Watch>((json) => Watch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load watches for brand: $brandId and family: $familyId ');
    }
  }

  Future<WatchDetails> getWatchDetails(int id) async {
    var response = await http.get(Uri.parse("$_apiUrl/watch?id=$id&format=json&key=$_apiKey"));
    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      return WatchDetails.fromJson(jsonData['watch']);
    } else {
      throw Exception('Failed to load watch details for watch: $id');
    }
  }
}
