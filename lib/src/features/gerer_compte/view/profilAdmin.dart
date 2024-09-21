import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:premierepage/src/features/gerer_compte/view/AdminConnect2.dart';
import 'package:premierepage/src/features/gerer_compte/view/gererComptes.dart';

class ProfilConnect extends StatefulWidget {
  @override
  _ProfilConnectState createState() => _ProfilConnectState();
}

class _ProfilConnectState extends State<ProfilConnect> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkIfProfileCompleted(); // Vérification des informations de profil
  }

  // Vérifier si le profil est déjà complété
  Future<void> _checkIfProfileCompleted() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Récupérer les données de profil dans Firestore
      DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
          .collection('utilisateur')
          .doc(user.uid)
          .get();

      if (profileSnapshot.exists && profileSnapshot['name'] != null && profileSnapshot['photoProfil'] != null) {
        // Profil déjà complété, rediriger vers la page principale
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminMainPage(profilePicture: profileSnapshot['photoProfil'])),
        );
      } else {
        // Profil non complété, rediriger vers la page de complétion du profil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminProfilePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Afficher un indicateur de chargement pendant la vérification
      ),
    );
  }
}






