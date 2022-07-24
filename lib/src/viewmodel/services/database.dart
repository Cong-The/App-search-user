import 'package:app_search_title/src/model/id_user.dart';
import 'package:app_search_title/src/model/the_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  //Firestore change FirebaseFirestore
  final CollectionReference demoCollection =
      FirebaseFirestore.instance.collection('TheUser');

  Future updateUserData(
    String name,
    //  String age,
    String address,
    String phone,
    // String interest
  ) async {
    return await demoCollection.doc(uid).set({
      'name': name,
      // 'age': age,
      'address': address,
      'phone': phone,
      // 'interest': interest,
    });
  }

  // TheUserData from snapshot
  IdUserData _theUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return IdUserData(
      uid: uid,
      name: snapshot.get('name'),
      // age: snapshot.get('age'),
      address: snapshot.get('address'),
      phone: snapshot.get('phone'),
      // interest: snapshot.get('interest'),
    );
  }

  Stream<IdUserData> get userData {
    return demoCollection.doc(uid).snapshots().map(_theUserDataFromSnapshot);
  }
}

class DataList {
  final CollectionReference demoCollection =
      FirebaseFirestore.instance.collection('TheUser');
  // Demo list from snapshot
  List<TheUser> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return TheUser(
        name: e.get('name') ?? '',
        // age: e.get('age') ?? '',
        address: e.get('address') ?? '',
        phone: e.get('phone') ?? '',
        // interest: e.get('interest') ?? '',
      );
    }).toList();
  }

  Stream<List<TheUser>> get listUser {
    return demoCollection.snapshots().map(_userListFromSnapshot);
  }
}
