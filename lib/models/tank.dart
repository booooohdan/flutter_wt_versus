class Tank {
  String link;
  String name;
  String image;
  String nation;
  String rank;
  List<String> BRs;
  bool isPremium;
  List<String> tankClass;
  List<String> features;
  String crew;
  String weight;
  List<String> vertGuidance;
  List<String> armorHull;
  List<String> armorTurret;
  List<String> speeds;
  List<String> reverseSpeeds;
  List<String> enginePowers;
  List<String> powerToWeights;
  List<String> repairCosts;
  String reloadTime;
  String cannon;

  Tank({
    required this.link,
    required this.name,
    required this.image,
    required this.nation,
    required this.rank,
    required this.BRs,
    required this.isPremium,
    required this.tankClass,
    required this.features,
    required this.crew,
    required this.weight,
    required this.vertGuidance,
    required this.armorHull,
    required this.armorTurret,
    required this.speeds,
    required this.reverseSpeeds,
    required this.enginePowers,
    required this.powerToWeights,
    required this.repairCosts,
    required this.reloadTime,
    required this.cannon,
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
      'tankClass': tankClass,
      'features': features,
      'crew': crew,
      'weight': weight,
      'vertGuidance': vertGuidance,
      'armorHull': armorHull,
      'armorTurret': armorTurret,
      'speeds': speeds,
      'reverseSpeeds': reverseSpeeds,
      'enginePowers': enginePowers,
      'powerToWeights': powerToWeights,
      'repairCosts': repairCosts,
      'reloadTime': reloadTime,
      'cannon': cannon,
    };
  }
}