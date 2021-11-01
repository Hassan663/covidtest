import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  Timestamp? createdAt;

  AuthModel(
      {this.uid, this.firstName, this.lastName, this.email, this.imageUrl, this.createdAt});

  AuthModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    print(doc.data());
    uid = doc.id;
    firstName = doc['firstName'];
    lastName = doc['lastName'];
    email = doc['email'];
    imageUrl = doc['imageUrl'];
    createdAt = doc['createdAt'];
  }
}
