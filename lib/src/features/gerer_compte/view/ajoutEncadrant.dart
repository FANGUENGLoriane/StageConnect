import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierepage/filepage.dart';
import 'package:premierepage/main.dart';


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
  final nomController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
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
          Icons.computer_outlined,
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
                'Stagiaire',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                  width: 360,
                  child: Form(
                      key: Formkey,
                      child: Column(children: [
                        TextFormField(
                            controller: nomController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Nom',
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
                                    hintText: 'veuillez entrer votre password',
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
                              onPressed:(){
    if (Formkey.currentState!.validate()) {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FilesPag()));
                              }
                              },

                              //
                              /* final email1 = emailController.text;
      final password1 = passwordController.text;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('envoi en cours ....'))
        );
        FocusScope.of(context).requestFocus(FocusNode());

        //ajout dans la bd
      CollectionReference conRef = FirebaseFirestore.instance.collection("connect");
      conRef.add({
        'email': email1,
        'password': password1,*/
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

