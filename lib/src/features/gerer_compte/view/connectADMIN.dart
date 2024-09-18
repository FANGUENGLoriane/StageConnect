import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierepage/main.dart';
import 'package:premierepage/src/features/elaborer_demande/view/nav_bar.dart';
import 'package:premierepage/src/features/elaborer_demande/view/specialite.dart';
import 'package:premierepage/src/features/gerer_compte/view/gererComptes.dart';

void main() {
  runApp(const connectADMIN());
}

class connectADMIN extends StatefulWidget {
  const connectADMIN({super.key});
  @override
  State<connectADMIN> createState() => _connectADMINState();
}

class _connectADMINState extends State<connectADMIN> {
  late Color myColor;
  late Size mediaSize;
  final Formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final String predefinedEmail = "AD";
  final String predefinedPassword = "A";
  void _validateAndNavigate() {
    if (Formkey.currentState!.validate()) {
      //verifie si les entrées du user correspondent aux donnees prédéfinies
      if (emailController.text == predefinedEmail &&
          passwordController.text == predefinedPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GererComptes(), // transmission des données
          ),

        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepOrangeAccent, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
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
                'CONNECTEZ-VOUS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                    color: Colors.deepOrangeAccent),
              ),
              const SizedBox(
                height: 9,
              ),
              const Text(
                'Veuillez remplir ces champs',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                  width: 338,
                  child: Form(
                      key: Formkey,
                      child: Column(children: [
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Email',
                                  style: TextStyle(fontSize: 20),
                                ),
                                hintText: 'veuillez entrer votre adresse email',
                                prefixIcon: Icon(Icons.email),
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
                              onPressed:()
                              async {
                                _validateAndNavigate;
                                FocusScope.of(context).requestFocus(FocusNode());
                                if (Formkey.currentState!.validate()) {
                                  String _email = emailController.text;
                                  String _mdp = passwordController.text;
                                  try {
                                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: _email,
                                      password: _mdp,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('connexion réussi')));
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>specialite(),
                                    ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'invalid-credential') {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email incorrect')));
                                    } else if (e.code == 'invalid-credential') {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('mot de passe érroné')));
                                    }
                                  }
                                }
                              },

                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>navBar()));
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
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                        SizedBox(height: 10,),
                        GestureDetector(
                            onTap:  (){
                              /*String emailAddress = "user@example.com";
                          if (passwordController != null) {
                            auth.SendPasswordResetEmailAsync(emailAddress).ContinueWith(task => {
                            if (task.IsCanceled) {
                            Debug.LogError("SendPasswordResetEmailAsync was canceled.");
                            return;
                            }
                            if (task.IsFaulted) {
                            Debug.LogError("SendPasswordResetEmailAsync encountered an error: " + task.Exception);
                            return;
                            }

                            Debug.Log("Password reset email sent successfully.");
                            });
                          }*/
                            }, child: Text('Mot de passe oublié ?')),
                        SizedBox(height: 10,),
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
