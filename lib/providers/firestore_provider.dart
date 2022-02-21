import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_cache/firestore_cache.dart';
import 'package:flutter/material.dart';

import '../models/plane.dart';

class FirestoreProvider with ChangeNotifier {
  // late int _intValue;
  //
  // int get intValue => _intValue;
  //
  // void setIntValue(int intValueParam) {
  //   _intValue = intValueParam;
  //   notifyListeners();
  // }

  final _fireStoreInstance = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getDocs() async {
    final cacheDocRef = _fireStoreInstance.doc('statusplane/status');
    final cacheField = 'updatedAt';
    final query = _fireStoreInstance.collection('planes').limit(10);
    final snapshot = await FirestoreCache.getDocuments(
      query: query,
      cacheDocRef: cacheDocRef,
      firestoreCacheField: cacheField,
    );

    return snapshot;
  }

  Future<List<Plane>> getPlanes() async {
    final List<Plane> planesList = [];
    await getDocs().then((value) => value.docs.forEach((doc) {
          final plane = Plane(
            link: doc['link'],
            name: doc['name'],
            image: doc['image'],
            nation: doc['nation'],
            rank: doc['rank'],
            BRs: doc['BRs'].cast<String>(),
            isPremium: doc['isPremium'],
            planeClass: doc['tankClass'].cast<String>(),
            //FIX THIS TO planeClass
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
          );

          planesList.add(plane);
        }));

    return planesList;
  }
}
