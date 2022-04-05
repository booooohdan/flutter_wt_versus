// ignore_for_file: non_constant_identifier_names

class Ship {
  Ship({
    required this.link,
    required this.name,
    required this.image,
    required this.nation,
    required this.rank,
    required this.BRs,
    required this.isPremium,
    required this.shipClass,
    required this.features,
    required this.numbOfSection,
    required this.displacement,
    required this.crew,
    required this.armors,
    required this.speeds,
    required this.reverseSpeeds,
    required this.repairCosts,
    required this.turrets,
  });

  String link;
  String name;
  String image;
  String nation;
  String rank;
  List<String> BRs;
  bool isPremium;
  List<String> shipClass;
  List<String> features;
  String numbOfSection;
  String displacement;
  String crew;
  List<String> armors;
  List<String> speeds;
  List<String> reverseSpeeds;
  List<String> repairCosts;
  List<String> turrets;
}
