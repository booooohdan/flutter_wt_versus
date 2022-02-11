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
  Plane? plane;

  Future<QuerySnapshot<Map<String, dynamic>>> getDocs() async {
    final cacheDocRef = _fireStoreInstance.doc('ateststatus/status');
    final cacheField = 'updatedAt';
    final query = _fireStoreInstance.collection('atestcollection');
    final snapshot = await FirestoreCache.getDocuments(
      query: query,
      cacheDocRef: cacheDocRef,
      firestoreCacheField: cacheField,
      isUpdateCacheDate: true
    );

    var a = snapshot.metadata.isFromCache;

    return snapshot;
  }

  Future<List<String>> getPlanes() async {
    List<String> planesList = [];

    await _fireStoreInstance.collection('planes').limit(10).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        var link = doc['link'];

        //this hack needed to store unique id value with "/" in firebase. E.g "Strv_m/39"
        if (link.contains('/')) {
          link = link.replaceAll('/', '');
        } //end of hack

        planesList.add(link);
      });
    });
    return planesList;
  }
}
