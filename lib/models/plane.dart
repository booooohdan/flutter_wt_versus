class Plane {
  String link;
  String name;
  String image;
  String nation;
  String rank;
  List<String> BRs;
  bool isPremium;
  List<String> planeClass;
  List<String> features;
  String turnTime;
  String maxAltitude;
  String engineName;
  String weight;
  String crew;
  String altitudeForSpeed;
  String speed;
  String engineType;
  String coolingSystem;
  String flutterStructural;
  String flutterGear;
  List<String> repairCosts;

  Plane({
    required this.link,
    required this.name,
    required this.image,
    required this.nation,
    required this.rank,
    required this.BRs,
    required this.isPremium,
    required this.planeClass,
    required this.features,
    required this.turnTime,
    required this.maxAltitude,
    required this.engineName,
    required this.weight,
    required this.crew,
    required this.altitudeForSpeed,
    required this.speed,
    required this.engineType,
    required this.coolingSystem,
    required this.flutterStructural,
    required this.flutterGear,
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
      'tankClass': planeClass,
      'features': features,
      'turnTime': turnTime,
      'maxAltitude': maxAltitude,
      'engineName': engineName,
      'weight': weight,
      'crew': crew,
      'altitudeForSpeed': altitudeForSpeed,
      'speed': speed,
      'engineType': engineType,
      'coolingSystem': coolingSystem,
      'flutterStructural': flutterStructural,
      'flutterGear': flutterGear,
      'repairCosts': repairCosts,
    };
  }
}