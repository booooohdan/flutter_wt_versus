class Heli {
  String link;
  String name;
  String image;
  String nation;
  String rank;
  List<String> BRs;
  bool isPremium;
  List<String> heliClass;
  List<String> features;
  String maxAltitude;
  String engineName;
  String weight;
  String crew;
  String speed;
  String flutterStructural;
  List<String> repairCosts;

  Heli({
    required this.link,
    required this.name,
    required this.image,
    required this.nation,
    required this.rank,
    required this.BRs,
    required this.isPremium,
    required this.heliClass,
    required this.features,
    required this.maxAltitude,
    required this.engineName,
    required this.weight,
    required this.crew,
    required this.speed,
    required this.flutterStructural,
    required this.repairCosts,
  });

  Map<String, dynamic> toMap() {
    return {
      'link': link,
      'name': name,
      'image': image,
      'nation': nation,
      'rank': rank,
      'BRs': BRs,
      'isPremium': isPremium,
      'heliClass': heliClass,
      'features': features,
      'maxAltitude': maxAltitude,
      'engineName': engineName,
      'weight': weight,
      'crew': crew,
      'speed': speed,
      'flutterStructural': flutterStructural,
      'repairCosts': repairCosts,
    };
  }
}