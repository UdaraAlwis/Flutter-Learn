import 'brand_family.dart';
import 'brand.dart';

class Watch {
  Watch({
    required this.id,
    required this.refnr,
    required this.name,
    required this.brand,
    required this.family,
    required this.thumb,
    required this.updated,
  });

  int id;
  String refnr;
  String name;
  Brand brand;
  BrandFamily family;
  String thumb;
  DateTime updated;

  factory Watch.fromJson(Map<String, dynamic> json) {
    return Watch(
        id: json['id'],
        refnr: json['refnr'],
        name: json['name'],
        brand: Brand.fromJson(json['brand']),
        family: BrandFamily.fromJson(json['family']),
        thumb: json['thumb'],
        updated: DateTime.parse(json['updated']));
  }
}
