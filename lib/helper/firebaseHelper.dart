import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static void addUser(Map temp) {
    _firestore.collection('users').add({
      'name': temp['name'],
      'email': temp['email'],
      'places': temp['places']
    });
  }

  static Future<List> getCollection(String collectionName) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(collectionName);
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  static Future<Map> getUserByKey(String key) async {
    DocumentReference docRef = _firestore.collection("users").doc(key);

    var ret;
    ret = await docRef.get().then((value) => value.data());

    return ret;
  }

  static Future<void> updateDocument(String key, var newData) async {
    DocumentReference docRef = _firestore.collection("users").doc(key);
    await docRef.update(newData);
  }

  static Future<String> getDocumentKey(
      String collectionName, String value) async {
    String ret = '';
    await FirebaseFirestore.instance
        .collection(collectionName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var z = doc.data() as Map;
        if (z['email'].toString().contains(value)) {
          ret = doc.reference.id.toString();
        }
      });
    });
    print(ret);
    return ret;
  }

  static void addComment(String name, String place, String comment) {
    _firestore.collection('comments').add({
      'name': name,
      'comment': comment,
      'place': place,
      'time': DateTime.now()
    });
  }
}
