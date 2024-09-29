import 'package:cloud_firestore/cloud_firestore.dart';

class Messagerie{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // declarons l'utilisateur actuel, le receveur et le message a envoyé
  sendMessage(String currentUid, String receiverUid, String message){
    // pour reconnaitre chaque message dans la bd
    List chatIds = [currentUid, receiverUid];
    //permet de recupérer a chaque fois un identifiant unique pour la communication
    chatIds.sort();
    //pour relier les deux discussions
    String chatId = chatIds.join('_');
    //stockage dans la bd
    _firestore.collection('Chats').doc(chatId).collection(chatId).add({
      'senderUid': currentUid,
      'receiverUid': receiverUid,
      'message': message,
      'chatId': chatId,
      'timeStamp': Timestamp.now()
    });

  }
}