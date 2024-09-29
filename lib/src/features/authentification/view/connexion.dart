import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierepage/src/features/chat/view/contacts.dart';
import 'package:premierepage/src/features/elaborer_demande/view/specialite.dart';
import 'package:premierepage/src/features/gerer_compte/view/profilAdmin.dart';
import 'package:premierepage/src/features/signup/views/Inscription.dart';

void main() {
  runApp(const connect());
}

class connect extends StatefulWidget {
  const connect({super.key});
  @override
  State<connect> createState() => _connectState();
}

class _connectState extends State<connect> {
  late Color myColor;
  late Size mediaSize;
  final Formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Fonction pour récupérer le token FCM
  /*Future<String?> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    //mise a jour du token
    messaging.onTokenRefresh.listen((newToken){
      saveFCMTokenToFirestore();
    });
    String? token = await messaging.getToken();
    return token;
  }

// Fonction pour enregistrer le token dans Firestore sous l'UID de l'utilisateur
  Future<void> saveFCMTokenToFirestore() async {

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? fcmToken = await getFCMToken();

      if (fcmToken != null) {
        await FirebaseFirestore.instance
            .collection('utilisateur')
            .doc(user.uid)        // Document avec l'UID de l'utilisateur
            .set({
          'fcmToken': fcmToken,
        }, SetOptions(merge: true));  // merge: true permet de ne pas écraser d'autres champs
      }
    } else {
      print('Utilisateur non connecté');
    }
  }
*/
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
            Positioned(bottom: 125,left: 10,right: 10, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
// centrer l'icone
      width: mediaSize.width,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
      height: 100,
      child:
        CircleAvatar(
          child:  Icon(
            Icons.person,
            color: Colors.grey[400],
            size: 40,
          ),
        ),),

        const Text(
          'Connectez-vous',
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
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    width: 304,
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
                                      border: OutlineInputBorder()
                                  ),
                                  obscureText: true,
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
                                onPressed: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (Formkey.currentState!.validate()) {
                                    String _email = emailController.text.trim();
                                    String _mdp = passwordController.text.trim();
                                    try {
                                      final credential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                        email: _email,
                                        password: _mdp,
                                      );
                                      // recupere l'uid de l'utilisateur courant
                                      String? curretUid = credential.user?.uid;

                                      //recupérons le doc selon le user
                                      DocumentSnapshot userDoc = await _firestore
                                          .collection('utilisateur')
                                          .doc(credential.user!.uid)
                                          .get();
                                      if (userDoc.exists) {
                                        String role = userDoc['typeCompte'];
                                        String uid = userDoc['uid'];
                                        //redirection basée sur le role
                                        if (role == 'Administrateur' && uid == 'NNgns1HITtbqRGeY2q1AGGgeuT83') {
                                         // 'uid': currentUid,
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text('Admin connecté !')));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilConnect()));
                                        }else if (role == 'Encadrant'){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text(' Encadrant connecté !')));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      chat()));
                                        }
                                      else {
                                       // await saveFCMTokenToFirestore();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'connexion réussi')));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => specialite(),
                                          ),
                                        );
                                      }} } on FirebaseAuthException catch (e) {
                                      if (e.code == 'invalid-credential') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text('Email incorrect')));
                                      } else if (e.code == 'invalid-credential') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text('mot de passe érroné')));
                                      }
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
                                  'Connexion',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {}, child: Text('Mot de passe oublié ?')),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: 285,
                              child: Row(
                                children: [
                                  Text('vous n\'avez pas de compte?'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Suivant()));
                                    },
                                    child: Text(
                                      'inscrivez-vous',
                                      style: GoogleFonts.roboto(
                                          color: Colors.deepOrangeAccent),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 28,
                                  ),
                                ],
                              ))
                        ])))
              ]),
            )));
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
