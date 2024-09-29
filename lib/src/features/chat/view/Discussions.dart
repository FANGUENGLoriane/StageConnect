import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierepage/src/features/FonctionnaliteChat/view/Messagerie.dart';
import 'package:premierepage/src/features/chat/view/Message.dart';
import 'package:premierepage/src/features/chat/view/contactModify.dart';

class Discussion extends StatefulWidget {
  Discussion({super.key, required this.mail, required this.uid});
final String mail;
final String uid;

  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  final messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    List chatIds = [auth.currentUser!.uid, widget.uid];
    //permet de recupérer a chaque fois un identifiant unique pour la communication
    chatIds.sort();
    //pour relier les deux discussions
    String chatId = chatIds.join('_');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mail,style: GoogleFonts.roboto(),),
      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              //recupérons tous les utilisateurs sauf celui qui est connecté

                stream: FirebaseFirestore.instance.collection('Chats').doc(chatId).collection(chatId).orderBy('timeStamp', descending: false ).snapshots(),

                builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){

                  //sinon
                  // creons une list  dynamic pour parcourir la snapshot et remplir la liste
                  List<dynamic> messages = [];
                  snapshot.data!.docs.forEach((_element){
                    messages.add(_element);

                  });
                  //si n'y il ya pas des elements dans la snapshot.... le point d'Exclamation ici c'est pour dire le contraire donc 's'il n'ya pas'
                  if(!snapshot.hasData){
                    return Text('aucun message pour l\'instant');

                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index){
                        final message = messages[index];
                        final messageContent = message['message'];
                        final senderUid = message['senderUid'];

                        return
                         Message(
                           message: messageContent,
                           ReceivedUid: senderUid,
                           currentUid: auth.currentUser!.uid,

                         );
                        //
                      }

                  );
                }),

            //pour le champ d'entré de texte
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Nouveau message',
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 1)
                    ),)
                  )),
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap: (){
                      //si le champ d'entré du texte n'est pas vide
                      if(messageController.text.isNotEmpty){
                        Messagerie().sendMessage(
                            auth.currentUser!.uid,
                            //recuperons le uid du receiver avec le widget pauisque c'est un stateful
                            widget.uid,
                            messageController.text);
                        messageController.text = '';
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:  Colors.deepOrangeAccent,
                      ),
                      child: Icon(Icons.send, color: Colors.white,),
                    ),
                  )
                ],
              ),

            )
          ],
        )
    );
  }
}
