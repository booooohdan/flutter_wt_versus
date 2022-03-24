import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_cache/firestore_cache.dart';
import 'package:flutter/material.dart';

import '../models/heli.dart';
import '../models/plane.dart';
import '../models/ship.dart';
import '../models/tank.dart';
import '../models/vehicles.dart';

class FirestoreProvider with ChangeNotifier {
  // Provider Example
  //
  // late int _intValue;
  //
  // int get intValue => _intValue;
  //
  // void setIntValue(int intValueParam) {
  //   _intValue = intValueParam;
  //   notifyListeners();
  // }

  final _fireStoreInstance = FirebaseFirestore.instance;

  // PLANES

  Future<QuerySnapshot<Map<String, dynamic>>> getPlanesDocs() async {
    final cacheDocRef = _fireStoreInstance.doc('statusplane/status');
    final cacheField = 'updatedAt';
    final query = _fireStoreInstance.collection('planes');
    final snapshot = await FirestoreCache.getDocuments(
      query: query,
      cacheDocRef: cacheDocRef,
      firestoreCacheField: cacheField,
    );

    return snapshot;
  }

  Future<List<Vehicle>> getSimplifiedPlanes() async {
    final List<Vehicle> planesList = [];
    await getPlanesDocs().then((value) => value.docs.forEach((doc) {
          final plane = Vehicle(
            link: doc['link'],
            name: doc['name'],
            nation: doc['nation'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            vehicleClass: doc['planeClass'].cast<String>(),
          );

          planesList.add(plane);
        }));

    return planesList;
  }

  Future<List<Plane>> getPlanes() async {
    final List<Plane> planesList = [];
    await getPlanesDocs().then((value) => value.docs.forEach((doc) {
          final plane = Plane(
            link: doc['link'],
            name: doc['name'],
            image: doc['image'],
            nation: doc['nation'],
            rank: doc['rank'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            planeClass: doc['planeClass'].cast<String>(),
            features: doc['features'].cast<String>(),
            turnTime: doc['turnTime'],
            maxAltitude: doc['maxAltitude'],
            engineName: doc['engineName'],
            weight: doc['weight'],
            crew: doc['crew'],
            altitudeForSpeed: doc['altitudeForSpeed'],
            speed: doc['speed'],
            engineType: doc['engineType'],
            coolingSystem: doc['coolingSystem'],
            flutterStructural: doc['flutterStructural'],
            flutterGear: doc['flutterGear'],
            repairCosts: doc['repairCosts'].cast<String>(),
            weapons: doc['weapons'].cast<String>(),
            turrets: doc['turrets'].cast<String>(),
          );

          planesList.add(plane);
        }));

    return planesList;
  }

  // TANKS

  Future<QuerySnapshot<Map<String, dynamic>>> getTanksDocs() async {
    final cacheDocRef = _fireStoreInstance.doc('statustank/status');
    final cacheField = 'updatedAt';
    final query = _fireStoreInstance.collection('tanks');
    final snapshot = await FirestoreCache.getDocuments(
      query: query,
      cacheDocRef: cacheDocRef,
      firestoreCacheField: cacheField,
    );

    return snapshot;
  }

  Future<List<Vehicle>> getSimplifiedTanks() async {
    final List<Vehicle> tanksList = [];
    await getTanksDocs().then((value) => value.docs.forEach((doc) {
          final tank = Vehicle(
            link: doc['link'],
            name: doc['name'],
            nation: doc['nation'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            vehicleClass: doc['tankClass'].cast<String>(),
          );

          tanksList.add(tank);
        }));

    return tanksList;
  }

  Future<List<Tank>> getTanks() async {
    final List<Tank> tanksList = [];
    await getTanksDocs().then((value) => value.docs.forEach((doc) {
          final tank = Tank(
            link: doc['link'],
            name: doc['name'],
            image: doc['image'],
            nation: doc['nation'],
            rank: doc['rank'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            tankClass: doc['tankClass'].cast<String>(),
            features: doc['features'].cast<String>(),
            crew: doc['crew'],
            weight: doc['weight'],
            vertGuidance: doc['vertGuidance'],
            armorHull: doc['armorHull'],
            armorTurret: doc['armorTurret'],
            speeds: doc['speeds'],
            reverseSpeeds: doc['reverseSpeeds'],
            enginePowers: doc['enginePowers'],
            powerToWeights: doc['powerToWeights'].cast<String>(),
            repairCosts: doc['repairCosts'].cast<String>(),
            reloadTime: doc['reloadTime'],
            cannon: doc['cannon'],
          );

          tanksList.add(tank);
        }));

    return tanksList;
  }

//HELICOPTERS

  Future<QuerySnapshot<Map<String, dynamic>>> getHelisDocs() async {
    final cacheDocRef = _fireStoreInstance.doc('statusheli/status');
    final cacheField = 'updatedAt';
    final query = _fireStoreInstance.collection('helis');
    final snapshot = await FirestoreCache.getDocuments(
      query: query,
      cacheDocRef: cacheDocRef,
      firestoreCacheField: cacheField,
    );

    return snapshot;
  }

  Future<List<Vehicle>> getSimplifiedHelis() async {
    final List<Vehicle> helisList = [];
    await getHelisDocs().then((value) => value.docs.forEach((doc) {
          final heli = Vehicle(
            link: doc['link'],
            name: doc['name'],
            nation: doc['nation'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            vehicleClass: doc['heliClass'].cast<String>(),
          );

          helisList.add(heli);
        }));

    return helisList;
  }

  Future<List<Heli>> getHelis() async {
    final List<Heli> helisList = [];
    await getHelisDocs().then((value) => value.docs.forEach((doc) {
          final heli = Heli(
            link: doc['link'],
            name: doc['name'],
            image: doc['image'],
            nation: doc['nation'],
            rank: doc['rank'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            heliClass: doc['heliClass'].cast<String>(),
            features: doc['features'].cast<String>(),
            maxAltitude: doc['maxAltitude'],
            engineName: doc['engineName'],
            weight: doc['weight'],
            crew: doc['crew'],
            speed: doc['speed'],
            flutterStructural: doc['flutterStructural'],
            repairCosts: doc['repairCosts'].cast<String>(),
            weapons: doc['weapons'].cast<String>(),
            turrets: doc['turrets'].cast<String>(),
          );

          helisList.add(heli);
        }));

    return helisList;
  }

//SHIPS

  Future<QuerySnapshot<Map<String, dynamic>>> getShipsDocs() async {
    final cacheDocRef = _fireStoreInstance.doc('statusship/status');
    final cacheField = 'updatedAt';
    final query = _fireStoreInstance.collection('ships');
    final snapshot = await FirestoreCache.getDocuments(
      query: query,
      cacheDocRef: cacheDocRef,
      firestoreCacheField: cacheField,
    );

    return snapshot;
  }

  Future<List<Vehicle>> getSimplifiedShips() async {
    final List<Vehicle> shipsList = [];
    await getShipsDocs().then((value) => value.docs.forEach((doc) {
          final ship = Vehicle(
            link: doc['link'],
            name: doc['name'],
            nation: doc['nation'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            vehicleClass: doc['shipClass'].cast<String>(),
          );

          shipsList.add(ship);
        }));

    return shipsList;
  }

  Future<List<Ship>> getShips() async {
    final List<Ship> shipsList = [];
    await getShipsDocs().then((value) => value.docs.forEach((doc) {
          final ship = Ship(
            link: doc['link'],
            name: doc['name'],
            image: doc['image'],
            nation: doc['nation'],
            rank: doc['rank'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            shipClass: doc['shipClass'].cast<String>(),
            features: doc['features'].cast<String>(),
            numbOfSection: doc['numbOfSection'],
            displacement: doc['displacement'],
            crew: doc['crew'],
            armors: doc['armors'].cast<String>(),
            speeds: doc['speeds'].cast<String>(),
            reverseSpeeds: doc['reverseSpeeds'].cast<String>(),
            repairCosts: doc['repairCosts'].cast<String>(),
            turrets: doc['turrets'].cast<String>(),
          );

          shipsList.add(ship);
        }));

    return shipsList;
  }
}
