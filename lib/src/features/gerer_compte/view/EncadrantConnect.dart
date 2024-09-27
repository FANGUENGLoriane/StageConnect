import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:premierepage/src/constant/size.dart';
import 'package:premierepage/src/features/gerer_compte/view/gererComptes.dart';
import 'package:premierepage/src/features/gerer_compte/view/profilAdmin.dart';
class EncadrantProfilePage extends StatefulWidget {
  const EncadrantProfilePage({super.key});

  @override
  State<EncadrantProfilePage> createState() => _EncadrantProfilePageState();
}
class _EncadrantProfilePageState extends State<EncadrantProfilePage> {

  final TextEditingController nameController = TextEditingController();
  File? _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = 'photoProfilEncadrant/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Erreur lors de l'upload : $e");
      return null;
    }
  }

  Future<void> _saveProfile(String name, String imageUrl) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('utilisateur').doc(user.uid).set({
          'name': name,
          'photoProfilEncadrant':imageUrl,
          'created_at': FieldValue.serverTimestamp(),
          'typeCompte': 'Encadrant'
        });
        // Une fois les informations sauvegardées, rediriger vers la page principale
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EncadrantMainPage(profilePicture2: imageUrl)),
        );
      }
    } catch (e) {
      print("Erreur lors de l'enregistrement dans Firestore : $e");
    }
  }

  void saveProfile() async {
    String name = nameController.text;
    if (name.isNotEmpty && _image != null) {
      String? imageUrl = await _uploadImageToFirebase(_image!);

      if (imageUrl != null) {
        await _saveProfile(name, imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profil sauvegardé")));
      } else {
        print('Erreur lors de l\'upload de l\'image');
      }

    } else {
      print('Complétez toutes les informations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compléter le Profil')),
      body:
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.add_a_photo, size: 40) : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProfile,
              child: Text('Enregistrer'),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}


class EncadrantMainPage extends StatefulWidget {
  final String profilePicture2;

  EncadrantMainPage({required this.profilePicture2});

  @override
  _EncadrantMainPageState createState() => _EncadrantMainPageState();
}

class _EncadrantMainPageState extends State<EncadrantMainPage> {
  File? _newImage;
  bool _isLoading = false;
  String? _updatedProfilePicture2;

  // Fonction pour choisir une nouvelle image depuis la galerie
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newImage = File(pickedFile.path);
      });
      _uploadAndSaveNewProfilePicture();
    }
  }

  // Fonction pour uploader la nouvelle image dans Firebase Storage
  Future<void> _uploadAndSaveNewProfilePicture() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String fileName = 'photoProfilEncadrant/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_newImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String newDownloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Mettre à jour Firestore avec la nouvelle photo de profil
      await _updateProfilePictureInFirestore(newDownloadUrl);
      setState(() {
        _updatedProfilePicture2 = newDownloadUrl;
      });
    } catch (e) {
      print("Erreur lors de la mise à jour de la photo : $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Mettre à jour la photo de profil dans Firestore
  Future<void> _updateProfilePictureInFirestore(String newImageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('utilisateur').doc(user.uid).update({
        'photoProfilEncadrant': newImageUrl,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BIENVENU')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              // Lorsque l'avatar est cliqué, l'utilisateur peut choisir une nouvelle image
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _updatedProfilePicture2 != null
                    ? NetworkImage(_updatedProfilePicture2!)
                    : NetworkImage(widget.profilePicture2),
                child: _isLoading ? CircularProgressIndicator() : null,
              ),
            ),
            SizedBox(height: 30),
            Text('Vous etes connectez en tant que Encadrant !'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Rediriger vers les fonctionnalités de l'administrateur
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GererComptes()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent ,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(borderRadius)),
              ),
              child: Text('Continuer', style: GoogleFonts.roboto(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }}