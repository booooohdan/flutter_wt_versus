class Vehicle {
  Vehicle({
    required this.link,
    required this.name,
    required this.image,
    required this.nation,
    required this.isPremium,
    required this.vehicleClass,
    required this.BRs,
  });

  String link;
  String name;
  String image;
  String nation;
  bool isPremium;
  List<String> vehicleClass;
  List<String> BRs;
}
