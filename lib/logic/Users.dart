import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  late String _userId;
  late String _name;
  late String _birthday;
  late ByteData _icon;

  late Map<String, dynamic> _dbProcessedMap;

  String get userId => _userId;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  Users({required String nameArg, required String birthdayArg, required ByteData iconArg}){
    _userId = nameArg;
    _name = nameArg;
    _birthday = birthdayArg;
    _icon = iconArg;

    _dbProcessedMap = {
      UsersTableColumn.NAME.name: _name, 
      UsersTableColumn.BIRTHDAY.name:_birthday,
      UsersTableColumn.ICON.name:_icon
    };
  }
}

class UserResistry{
  final db = FirebaseFirestore.instance;

  late Users _user;

  UserResistry(this._user);

  Future add() async{
    await db
      .collection("users")
      .doc(_user.userId)
      .set(_user.dbProcessedMap);
  }

  Future update({required Users newUserDataArg, required UsersTableColumn columnArg}) async{
    await db
      .collection("users")
      .doc(_user.userId)
      .update(_user.dbProcessedMap);
  }
}

enum UsersTableColumn{
  NAME,
  BIRTHDAY,
  ICON
}