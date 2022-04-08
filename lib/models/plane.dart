// ignore_for_file: non_constant_identifier_names

class Plane {
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
    required this.weapons,
    required this.turrets,
  });

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
  List<String> weapons;
  List<String> turrets;
}
