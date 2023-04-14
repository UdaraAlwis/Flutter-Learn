class BrandFamily {
  BrandFamily({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory BrandFamily.fromJson(Map<String, dynamic> json) {
    return BrandFamily(
      id: json['id'],
      name: json['name'],
    );
  }
}
