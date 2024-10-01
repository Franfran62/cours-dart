import 'package:cloud_firestore/cloud_firestore.dart';

Stream collectionStream = FirebaseFirestore.instance.collection('pizza').snapshots();