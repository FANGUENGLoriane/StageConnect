import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierepage/filepage.dart';
import 'package:premierepage/main.dart';
import 'package:premierepage/src/features/authentification/view/connexion.dart';


void main() {
  runApp(const ajoutEncadrant());
}

class ajoutEncadrant extends StatefulWidget {
  const ajoutEncadrant({super.key});

  @override
  State<ajoutEncadrant> createState() => _ajoutEncadrantState();
}

class _ajoutEncadrantState extends State<ajoutEncadrant> {
  late Color myColor;
  late Size mediaSize;
  final Formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: const AssetImage('image/main.JPG'),
              //COULEUR au dessus de l'image
              colorFilter: ColorFilter.mode(
                  myColor.withOpacity(0.4), BlendMode.dstATop))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 70, child: _buildTop()),
            Positioned(bottom: 155, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
// centrer l'icone
      width: mediaSize.width,
      child: const Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(
          Icons.person,
          color: Colors.white,
          size: 110,
        ),
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
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(children: [
              SizedBox(height: 15),
              const Text(
                'Enregistrer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                    color: Colors.deepOrangeAccent),
              ),
              const SizedBox(
                height: 9,
              ),
              const Text(
                'Encadrant',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                  width: 334,
                  child: Form(
                      key: Formkey,
                      child: Column(children: [
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Email',
                                  style: TextStyle(fontSize: 20),
                                ),
                                hintText: 'Email de l\'encadrant',
                                prefixIcon: Icon(Icons.person_2),
                                border: OutlineInputBorder()),
                            onChanged: (String value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'veuillez remplir ce champs!';
                              }
                              return null;
                            }),
                        const SizedBox(
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
                                    hintText: 'attribuez un mot de passe',
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'veuillez remplir ce champs';
                                  }
                                  return null;
                                })),
                        SizedBox(height: 25),
                        SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed:() async{
                                FocusScope.of(context).requestFocus(FocusNode());
                                if (Formkey.currentState!.validate()) {
                                  String _mdp = passwordController.text;
                                  String _email = emailController.text;

                                  try {
                                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: _email,
                                      password: _mdp,

                                    );
                                    String? currentUid = credential.user?.uid;
                                    //ajout a la bd
                                    _firestore.collection('utilisateur').doc(currentUid).set({
                                      'email': _email,
                                      'uid': currentUid,
                                      'typeCompte': 'Encadrant',
                                      //'photoProfil': 'utilisateur/defaultProfil.webp',
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Encadrant ajouté avec succes')));
                                  } on FirebaseAuthException catch (e) {

                                    if (e.code == 'weak-password') {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Le mot de passe est faible')));
                                    } else if (e.code == 'email-already-in-use') {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>connect()));
                                    }
                                    else if (e.code == 'invalid-email') {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('L\'adresse mail est invalid')));
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString())));
                                  }
                                }

                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 6,
                                  backgroundColor: Colors.deepOrangeAccent,
                                  minimumSize: const Size.fromHeight(40)),
                              child: const Text(
                                'Enregistrer',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
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

