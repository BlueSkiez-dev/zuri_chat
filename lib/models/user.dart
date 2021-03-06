import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = 'id';
  static const NAME = 'name';
  static const PHOTO = 'photo';

  String _id;
  String _name;
  String _photo;

  // getters
  String get name => _name;
  String get photo => _photo;
  String get id => _id;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _id = snapshot.data()[ID];
    _photo = snapshot.data()[PHOTO];
  }
}
