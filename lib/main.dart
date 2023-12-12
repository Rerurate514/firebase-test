import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/firebase_options.dart';
import 'package:test/logic/Users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserResistry userResistry = UserResistry();
  final UserDataFetcher userDataFetcher = UserDataFetcher();

  bool _isLogin = false;

  String _email = "";
  String _password = "";

  String _name = "";
  String _birthday = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value){
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "パスワード"),
                onChanged: (String value){
                  setState(() {
                    _password = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "名前"),
                onChanged: (String value){
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "誕生日"),
                onChanged: (String value){
                  setState(() {
                    _birthday = value;
                  });
                },
              ),
              ElevatedButton(
                child: const Text("ユーザ登録"),
                onPressed: () async {
                  try{
                    final User? user = (
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email, 
                        password: _password
                      )
                    ).user;

                    if(user == null) return;
                    print("ユーザ登録しました");

                    final Users newUser = Users(
                      nameArg: _name,
                      birthdayArg: _birthday, 
                      iconLocalPathArg: "",
                      emailArg: _email
                    );

                    userResistry.add(newUserDataArg: newUser);
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                child: const Text("ログイン"),
                onPressed: () async {
                  try{
                    final User? user = (
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, 
                        password: _password
                      )
                    ).user;

                    if(user == null) return;
                    print("ログインしました");
                    _isLogin = true;
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                child: const Text("データ取得"),
                onPressed: () async {
                  if(!_isLogin) {
                    print("ログインしてください");
                    return;
                  }

                  final fetchedDataMap = await userDataFetcher.fetch(targetUserIdArg:_email);

                  print(fetchedDataMap[UsersTableColumn.NAME.name]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
    