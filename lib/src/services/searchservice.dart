import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataCrontroller extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }
}
