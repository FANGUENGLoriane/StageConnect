import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierepage/src/features/authentification/view/connexion.dart';
import 'package:premierepage/src/features/chat/view/Discussions.dart';
import 'package:premierepage/src/features/chat/view/contactModify.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    return Scaffold(

      appBar: AppBar(
        title: Text('chat'),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>connect()));
            },
            child: Icon(Icons.logout)
          )
        ],
      ),
      body:
      // le stream affiche les elements de la bd

      StreamBuilder(
        //recupérons tous les utilisateurs sauf celui qui est connecté

          stream: FirebaseFirestore.instance.collection('utilisateur').where('uid', isNotEqualTo: currentUser.currentUser!.uid).snapshots(),

          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){

            //sinon
            // creons une list  dynamic pour parcourir la snapshot et remplir la liste
            List<dynamic> users = [];
            snapshot.data!.docs.forEach((_element){
              users.add(_element);

            });
            //si n'y il ya pas des elements dans la snapshot.... le point d'Exclamation ici c'est pour dire le contraire donc 's'il n'ya pas'
            if(!snapshot.hasData){
              return Text('aucun utilisateur');

            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
                itemBuilder: (context, index){
                  final user = users[index];
                  final userMail = user['email'];
                 final userUid = user['uid'];

                  return
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Discussion(mail: userMail, uid: userUid,)));
                      },
                      child: Contactmodify(userMail: userMail, userUid: userUid)
                      ,
                    );
                    //
                }

            );
          })
    );
  }
}
