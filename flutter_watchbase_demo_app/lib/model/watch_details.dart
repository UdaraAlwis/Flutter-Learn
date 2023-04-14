import 'brand.dart';
import 'brand_family.dart';

class WatchDetails {
  Wb? wb;
  String? referenceNumber;
  String? name;
  String? gender;
  String? released;
  String? stopped;
  int? limitedNr;
  String? waterresistance;
  String? description;
  Brand? brand;
  BrandFamily? family;
  Caliber? caliber;
  WatchCase? watchCase;
  Dial? dial;
  List<String>? images;
  List<Prices>? prices;

  WatchDetails({
    required this.wb,
    this.referenceNumber,
    this.name,
    this.gender,
    this.released,
    this.stopped,
    this.limitedNr,
    this.waterresistance,
    this.description,
    this.brand,
    this.family,
    this.caliber,
    this.watchCase,
    this.dial,
    this.images,
    this.prices,
  });

  factory WatchDetails.fromJson(Map<String, dynamic> json) {
    return WatchDetails(
      wb: json['wb'] != null ? Wb.fromJson(json['wb']) : null,
      referenceNumber: json['reference_number'],
      name: json['name'],
      gender: json['gender'],
      released: json['released'],
      stopped: json['stopped'],
      limitedNr: json['limited_nr'],
      waterresistance: json['waterresistance'],
      description: json['description'],
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      family: json['family'] != null ? BrandFamily.fromJson(json['family']) : null,
      caliber: json['caliber'] != null ? Caliber.fromJson(json['caliber']) : null,
      watchCase: json['case'] != null ? WatchCase.fromJson(json['case']) : null,
      dial: json['dial'] != null ? Dial.fromJson(json['dial']) : null,
      // ignore: prefer_null_aware_operators
      images: json['images'] != null ? json['images'].cast<String>() : null,
      // ignore: prefer_null_aware_operators
      prices: json['prices'] != null ? json['prices'].map<Prices>((json) => Prices.fromJson(json)).toList() : null,
    );
  }
}

class Wb {
  final int? id;
  final String? added;
  final String? modified;
  final String? published;

  Wb({required this.id, required this.added, required this.modified, required this.published});

  factory Wb.fromJson(Map<String, dynamic> json) {
    return Wb(
      id: json['id'],
      added: json['added'],
      modified: json['modified'],
      published: json['published'],
    );
  }
}

class Caliber {
  final int? id;
  final String? referenceNumber;
  final String? image;
  final String? diameter;
  final int? jewels;
  final int? frequency;
  final String? powerreserve;
  final String? brand;
  final String? type;
  final String? display;
  final String? description;
  final int? parentCaliber;
  final String? acoustic;
  final String? additional;

  Caliber({
    required this.id,
    required this.referenceNumber,
    required this.image,
    required this.diameter,
    required this.jewels,
    required this.frequency,
    required this.powerreserve,
    required this.brand,
    required this.type,
    required this.display,
    required this.description,
    required this.parentCaliber,
    required this.acoustic,
    required this.additional,
  });

  factory Caliber.fromJson(Map<String, dynamic> json) {
    return Caliber(
      id: json['id'],
      referenceNumber: json['reference_number'],
      image: json['image'],
      diameter: json['diameter'],
      jewels: json['jewels'],
      frequency: json['frequency'],
      powerreserve: json['powerreserve'],
      brand: json['brand'],
      type: json['type'],
      display: json['display'],
      description: json['description'],
      parentCaliber: json['parent_caliber'],
      acoustic: json['acoustic'],
      additional: json['additional'],
    );
  }
}

class WatchCase {
  List<String>? materials;
  String? coating;
  String? bezel;
  String? glass;
  String? back;
  String? shape;
  String? diameter;
  String? height;
  String? lugwidth;

  WatchCase({
    required this.materials,
    required this.coating,
    required this.bezel,
    required this.glass,
    required this.back,
    required this.shape,
    required this.diameter,
    required this.height,
    required this.lugwidth,
  });

  factory WatchCase.fromJson(Map<String, dynamic> json) {
    return WatchCase(
      materials: json['materials'].cast<String>(),
      coating: json['coating'],
      bezel: json['bezel'],
      glass: json['glass'],
      back: json['back'],
      shape: json['shape'],
      diameter: json['diameter'],
      height: json['height'],
      lugwidth: json['lugwidth'],
    );
  }
}

class Dial {
  final String? nickname;
  final String? color;
  final String? material;
  final String? finish;
  final String? indextype;
  final String? handstyle;

  Dial(
      {required this.nickname,
      required this.color,
      required this.material,
      required this.finish,
      required this.indextype,
      required this.handstyle});

  factory Dial.fromJson(Map<String, dynamic> json) {
    return Dial(
      nickname: json['nickname'],
      color: json['color'],
      material: json['material'],
      finish: json['finish'],
      indextype: json['indextype'],
      handstyle: json['handstyle'],
    );
  }
}

class Prices {
  String? currency;
  String? watchPrice;
  String? date;

  Prices({
    required this.currency,
    required this.watchPrice,
    required this.date,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      currency: json['currency'],
      watchPrice: json['watch_price'],
      date: json['date'],
    );
  }
}
