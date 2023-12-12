import 'package:cloud_firestore/cloud_firestore.dart';

const USERS_TABLE_COLLECTION_NAME = "users";

///このデータベースでのdocumentId(userId)はメールアドレスとなる。
///これは、Firebase.Authenticationでメール登録するするときに、
///重複が許されないため、一意な値になるからである。
///
///todo 他サービスでのアカウント作成からFirestoreへの登録にはもう少し工夫が必要かと思われる。
class Users{
  late final String _userId;
  late final String _name;
  late final String _birthday;
  late final String _iconImageLocalPath;
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
    _iconImageLocalPath = iconLocalPathArg;
    _email = emailArg;

    _dbProcessedMap = {
      UsersTableColumn.NAME.name: _name, 
      UsersTableColumn.BIRTHDAY.name:_birthday,
      UsersTableColumn.ICON_Image_LOCAL_PATH.name:_iconImageLocalPath,
      UsersTableColumn.EMAIL.name: _email
    };
  }
}

class UserResistry{
  final db = FirebaseFirestore.instance;

  Future add({required Users newUserDataArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(newUserDataArg.userId)
      .set(newUserDataArg.dbProcessedMap);
  }

  Future update({required Users newUserDataArg, required UsersTableColumn columnArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(newUserDataArg.userId)
      .update(newUserDataArg.dbProcessedMap);
  }
}

class UserDataFetcher{
  final db = FirebaseFirestore.instance;

  ///Mapデータを取得するときは、取得した変数[UsersTableColumn.カラム名（データベースの項目名）.name]と記述する。
  Future<Map<String, dynamic>> fetch({required String targetUserIdArg}) async{
    final fetchedUser = await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(targetUserIdArg)
      .get();

    return fetchedUser.data() ?? {};
  }
}

enum UsersTableColumn{
  NAME,
  BIRTHDAY,
  ICON_Image_LOCAL_PATH,
  EMAIL
}