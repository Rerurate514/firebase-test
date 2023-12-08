import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  late String _userId;
  late String _name;
  late String _birthday;
  late ByteData _icon;

  String get userId => _userId;
  String get name => _name;
  String get birthday => _birthday;
  ByteData get icon => _icon;

  Users({required String nameArg, required String birthdayArg, required ByteData iconArg}){
    _userId = nameArg;
    _name = nameArg;
    _birthday = birthdayArg;
    _icon = iconArg;
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
      .set({
        UsersTableColumn.NAME.name:_user.name, 
        UsersTableColumn.BIRTHDAY.name:_user.birthday,
        UsersTableColumn.ICON.name:_user.icon 
      });
  }

  Future update<COLUMN extends UsersTableColumn>({required Users newUserDataArg}) async{
    await db
      .collection("users")
      .doc(_user.userId)
      .update({COLUMN: ""});
  }
}

enum UsersTableColumn{
  NAME,
  BIRTHDAY,
  ICON
}