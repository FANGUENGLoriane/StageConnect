import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierepage/main.dart';
import 'package:premierepage/src/features/authentification/view/connexion.dart';
import 'package:premierepage/src/features/elaborer_demande/view/nav_bar.dart';
import 'package:premierepage/src/features/gerer_compte/view/gererComptes.dart';

void main() {
  runApp(const ajouStagiaire());
}

class ajouStagiaire extends StatefulWidget {
  const ajouStagiaire({super.key});

  @override
  State<ajouStagiaire> createState() => _ajouStagiaireState();
}

class _ajouStagiaireState extends State<ajouStagiaire> {
  late Color myColor;
  late Size mediaSize;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: const AssetImage('image/ordi8.jpg'),
              //COULEUR au dessus de l'image
              colorFilter: ColorFilter.mode(
                  myColor.withOpacity(0.4), BlendMode.dstATop))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 70, child: _buildTop()),
            Positioned(bottom: -4, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(
          Icons.computer_outlined,
          color: Colors.white,
          size: 110,
        ),
        Text(
          'Inscription',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Colors.deepOrangeAccent),
        )
      ]),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
        width: mediaSize.width,
        child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'Ajouter ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                    color: Colors.deepOrangeAccent),
              ),
              SizedBox(
                height: 13,
              ),
              Text(
                'Un Stagiaire',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                  width: 335,
                  child: Form(
                      key: formkey,
                      child: Column(children: [
                        TextFormField(
                            controller: nomController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Nom du stagiare',
                                  style: TextStyle(fontSize: 20),
                                ),
                                hintText: 'veuillez entrer votre nom',
                                prefixIcon: Icon(Icons.person_2),
                                border: OutlineInputBorder()),
                            onChanged: (String value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'veuillez remplir ce champs!';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                            width: 360,
                            child: TextFormField(
                                // key: formkey,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    label: Text(
                                      'Email',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    hintText: ' email',
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'veuillez remplir ce champs';
                                  }
                                  return null;
                                })),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                            width: 360,
                            child: TextFormField(
                                // key: formkey,
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                    label: Text(
                                      'Password',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    hintText: 'password',
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'veuillez remplir ce champs';
                                  }
                                  return null;
                                })),
                        SizedBox(height: 30),
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.deepOrangeAccent)),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (formkey.currentState!.validate()) {
                                String _mdp = passwordController.text;
                                String _email = emailController.text;
                                String _nom = nomController.text;

                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: _email,
                                    password: _mdp,
                                  );
                                  String? currentUid = credential.user?.uid;
                                  //ajout a la bd
                                  _firestore
                                      .collection('utilisateur')
                                      .doc(currentUid)
                                      .set({
                                    'nom': _nom,
                                    'uid': currentUid,
                                    'typeCompte': 'stagiaire',
                                    //'photoProfil': 'utilisateur/defaultProfil.webp',
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Ajouter avec succes')));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Le mot de passe est faible')));
                                  } else if (e.code == 'email-already-in-use') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GererComptes()));
                                  } else if (e.code == 'invalid-email') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'L\'adresse mail est invalid')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                              ;
                            },
                            child: Text(
                              'Ajouter',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        SizedBox(height: 15)
                      ])))
            ])));
  }
}

// FAIRE UN DEGRADÉ
/*Container(
     decoration: const BoxDecoration(
         gradient: LinearGradient(
             colors: [Colors.deepOrangeAccent, Colors.white],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight)
     ),
        )*/
