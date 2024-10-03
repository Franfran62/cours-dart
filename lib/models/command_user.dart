import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/enums/paiement_type.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:cours_flutter/models/user.dart' as app;

class CommandUser {
  final String? id;
  final app.User userLinked;
  final List<Product> products;
  final double total;
  final PaiementType paiementType;

  CommandUser(
      {this.id,
      required this.userLinked,
      required this.products,
      required this.total,
      required this.paiementType});

  factory CommandUser.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return CommandUser(
      userLinked: app.User.fromSnapshot(doc['userLinked']),
      products: Product.fromListSnapshot(doc['products']),
      total: doc['total'],
      paiementType:
          PaiementType.values.firstWhere((e) => e.getName() == doc['paiementType']),
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'userLinked': userLinked.toSnapshot(),
      'products': products.map((product) => product.toSnapshot()).toList(),
      'total': total,
      'paiementType': paiementType.name,
    };
  }
}
