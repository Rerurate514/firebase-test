import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

const USERS_TABLE_COLLECTION_NAME = "users";

class Users{
  late final String _userId;
  late final String _name;
  late final String _birthday;
  late final String _iconLocalPath;
  late final String _email;

  late final Map<String, dynamic> _dbProcessedMap;

  String get userId => _userId;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  Users({
    required String nameArg, 
    required String birthdayArg, 
    required String iconLocalPathArg, 
    required String emailArg
  }){
    _userId = emailArg;
    _name = nameArg;
    _birthday = birthdayArg;
    _iconLocalPath = iconLocalPathArg;
    _email = emailArg;

    _dbProcessedMap = {
      UsersTableColumn.NAME.name: _name, 
      UsersTableColumn.BIRTHDAY.name:_birthday,
      UsersTableColumn.ICON_LOCAL_PATH.name:_iconLocalPath,
      UsersTableColumn.EMAIL.name: _email
    };
  }
}

class UserResistry{
  final db = FirebaseFirestore.instance;

  late Users _user;

  UserResistry(this._user);

  Future add() async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(_user.userId)
      .set(_user.dbProcessedMap);
  }

  Future update({required Users newUserDataArg, required UsersTableColumn columnArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(_user.userId)
      .update(_user.dbProcessedMap);
  }
}

class UserDataFetcher{
  final db = FirebaseFirestore.instance;

  late final String _email;

  UserDataFetcher(this._email);

  Future<Map<String, dynamic>> fetch() async{
    final fetchedUser = await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(_email)
      .get();

    return fetchedUser.data() ?? {};
  }
}

enum UsersTableColumn{
  NAME,
  BIRTHDAY,
  ICON_LOCAL_PATH,
  EMAIL
}