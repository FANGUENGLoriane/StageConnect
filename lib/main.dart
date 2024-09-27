import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:premierepage/src/features/home/views/home.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Activer App Check avec le fournisseur de votre choix
  await FirebaseAppCheck.instance.activate(

    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),

    androidProvider: AndroidProvider.debug,

    appleProvider: AppleProvider.appAttest,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
