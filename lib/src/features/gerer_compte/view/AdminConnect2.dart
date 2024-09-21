import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:premierepage/src/features/gerer_compte/view/gererComptes.dart';
import 'package:premierepage/src/features/gerer_compte/view/profilAdmin.dart';
class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {

  final TextEditingController nameController = TextEditingController();
  File? _image;
  bool _isLoading = false;
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
      String fileName = 'photoProfil/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
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
          'photoProfil':imageUrl,
          'created_at': FieldValue.serverTimestamp(),
          'typeCompte': 'Administrat'
        });
        // Une fois les informations sauvegardées, rediriger vers la page principale
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminMainPage(profilePicture: imageUrl)),
        );
      }
    } catch (e) {
      print("Erreur lors de l'enregistrement dans Firestore : $e");
    }
  }

  void saveProfile() async {
    String name = nameController.text;
    if (name.isNotEmpty && _image != null) {
      setState(() {
        _isLoading = true;
      });

      String? imageUrl = await _uploadImageToFirebase(_image!);

      if (imageUrl != null) {
        await _saveProfile(name, imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profil sauvegardé")));
      } else {
        print('Erreur lors de l\'upload de l\'image');
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      print('Complétez toutes les informations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compléter le Profil')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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


class AdminMainPage extends StatefulWidget {
  final String profilePicture;

  AdminMainPage({required this.profilePicture});

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  File? _newImage;
  bool _isLoading = false;
  String? _updatedProfilePicture;

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
      String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_newImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String newDownloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Mettre à jour Firestore avec la nouvelle photo de profil
      await _updateProfilePictureInFirestore(newDownloadUrl);
      setState(() {
        _updatedProfilePicture = newDownloadUrl;
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
        'photoProfil': newImageUrl,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Principale')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              // Lorsque l'avatar est cliqué, l'utilisateur peut choisir une nouvelle image
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _updatedProfilePicture != null
                    ? NetworkImage(_updatedProfilePicture!)
                    : NetworkImage(widget.profilePicture),
                child: _isLoading ? CircularProgressIndicator() : null,
              ),
            ),
            SizedBox(height: 20),
            Text('Bienvenue, Administrateur !'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Rediriger vers les fonctionnalités de l'administrateur
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GererComptes()),
                );
              },
              child: Text('Continuer'),
            ),
          ],
        ),
      ),
    );
  }}