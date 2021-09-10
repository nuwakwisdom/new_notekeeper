import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName) async {
  CollectionReference user = FirebaseFirestore.instance.collection('user');
}
