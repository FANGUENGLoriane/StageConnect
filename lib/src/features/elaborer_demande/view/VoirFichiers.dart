import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class VoirFichiers extends StatefulWidget {
  const VoirFichiers({super.key});

  @override
  State<VoirFichiers> createState() => _VoirFichiersState();
}

class _VoirFichiersState extends State<VoirFichiers> {
  List<String> fileName = [];
  List<String> downloadUrl=[];
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
  fetchFichiersImporter();
  }
  //recupérons les fichiers importés
  Future<void>
  fetchFichiersImporter() async{
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('veuillez vous connecter')));
      return;
    }
    String uid = user.uid;
    try{
      //recupérons la reference du dossierdu user
    final storageRef = FirebaseStorage.instance.ref().child('users/$uid');
      //récupérons la liste des fichiers
   final ListResult result = await storageRef.listAll();
   List<String> tempFileNames = [];
   List<String> tempDownloadUrl = [];
    //parcourrir chaque fichier dans le dossier
      for(var ref in result.items){
        final String fileNames = ref.name;
        tempFileNames.add(fileNames);
      }
      setState(() {
        fileName = tempFileNames;
        isLoading = false;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('erreur')));
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Vos fichiers importés'),
      ),
      
      body:

      isLoading? Center(
        child: CircularProgressIndicator()):fileName.isEmpty?
      Center(child: Text('aucun fichier importé trouver'),):
          ListView.builder(
              itemCount: fileName.length,
              itemBuilder: (context, id){
                return
                  SizedBox(
                    height: 70,

                    child:
                  Card(
                  child:
                      Column(
                children: [
                   Text(fileName[id],),
                  ])
                  ));
              })
    );
  }
}
