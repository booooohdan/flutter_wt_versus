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
  List<String> repairCosts;
  List<String> turrets;

  Map<String, dynamic> toMap() {
    return {
      'link': link,
      'name': name,
      'image': image,
      'nation': nation,
      'rank': rank,
      'BRs': BRs,
      'isPremium': isPremium,
      'shipClass': shipClass,
      'features': features,
      'numbOfSection': numbOfSection,
      'displacement': displacement,
      'crew': crew,
      'armors': armors,
      'speeds': speeds,
      'repairCosts': repairCosts,
      'turrets': turrets,
    };
  }
}
