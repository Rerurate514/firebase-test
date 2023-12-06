import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/firebase_options.dart';

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
  String _email = "";
  String _passward = "";

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
                    _passward = value;
                  });
                },
              ),
              ElevatedButton(
                child: const Text("ユーザ登録"),
                onPressed: () async {
                  // try{
                  //   final User? user = (await )
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
    