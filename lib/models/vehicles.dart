// ignore_for_file: non_constant_identifier_names

class Vehicle {
  Vehicle({
    required this.link,
    required this.name,
    required this.image,
    required this.nation,
    required this.rank,
    required this.isPremium,
    required this.vehicleClass,
    required this.BRs,
  });

  String link;
  String name;
  String image;
  String nation;
  String rank;
  bool isPremium;
  List<String> vehicleClass;
  List<String> BRs;
}
