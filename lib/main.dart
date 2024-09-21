import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:premierepage/src/features/authentification/view/home_login.dart';
import 'package:premierepage/src/features/gerer_compte/view/gererComptes.dart';
import 'package:premierepage/src/features/gerer_compte/view/profilAdmin.dart';
import 'package:premierepage/src/features/home/views/home.dart';
import 'package:premierepage/src/features/signup/views/suivant.dart';
import 'firebase_options.dart';
import'package:firebase_storage/firebase_storage.dart';

void main() async{
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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
