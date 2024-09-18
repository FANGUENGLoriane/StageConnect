import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:premierepage/filepage.dart';
import 'package:premierepage/src/constant/images.dart';
import 'package:premierepage/src/features/elaborer_demande/view/VoirFichiers.dart';

class SoumissionCyber extends StatefulWidget {
  const SoumissionCyber({
    super.key,
  });

  @override
  State<SoumissionCyber> createState() => _SoumissionCyberState();
}

class _SoumissionCyberState extends State<SoumissionCyber> {
  List<String> filesTexts = [
    'Demande',
    'CV',
    'Certificat',
    'Photocopie CNI',
    "Photos",
  ];
  // variables pour stocker le nom des fichiers sélectionnés
  List<String?> filesName = [
    null,
    null,
    null,
    null,
    null,
  ];
  // Progression de l'upload
  double uploadProgress = 0.0;
  // Vérifie si tous les fichiers ont été sélectionnés
  bool get allFilesSelected => filesName.every((filePath) => filePath != null);
  // Fonction pour sélectionner un fichier
  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        // Mettre à jour le chemin du fichier sélectionné
        filesName[index] = result.files.single.path;
        filesTexts[index] =
            filesTexts[index] + ' : ' + ' ' + result.files.single.name;
      });
    }
  }

  // Fonction pour télécharger les fichiers vers Firebase Storage
  Future<void> uploadFiles() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Veuillez vous connecter avant d'importer des fichiers.")),
      );
      return;
    }

    String uid = user.uid; // Récupération de l'UID de l'utilisateur
    try {
      int filesCount = 5;
      for (int i = 0; i < filesCount; i++) {
        String filePath = filesName[i]!;
        String fileName = filesTexts[i];
        // Récupérer le fichier à partir du chemin
        File file = File(filePath);

        // Téléchargement du fichier vers un dossier identifié par l'UID de l'utilisateur
        UploadTask task =
            FirebaseStorage.instance.ref('users/$uid/$fileName').putFile(file);

        task.snapshotEvents.listen((TaskSnapshot snapshot) {
          setState(() {
            // Mise à jour de la barre de progression
            uploadProgress =
                (snapshot.bytesTransferred / snapshot.totalBytes) / filesCount +
                    (i / filesCount);
          });
        });

        // Attente que le fichier soit complètement téléchargé
        await task.whenComplete(() => null);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Tous les fichiers ont été téléchargés avec succès !")),
      );
      setState(() {
        uploadProgress =
            0.0; // Réinitialiser la barre de progression après téléchargement
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Erreur lors du téléchargement des fichiers : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Image.asset(
        cyberS,
        height: 135,
      ),
      Column(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),

        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Center(
            child: Text(
              'C\'est un domaine de l\'informatique qui se concentre sur la protection des systemes, des réseaux et des données contre '
              'les me-\nnaces et les attaques informatiques',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        const Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                '- - - Importer - - -',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
//
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              // constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
              //  padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Column(children: [
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () => pickFile(i),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            filesTexts[i],
                            style: GoogleFonts.roboto(
                                color: Colors.deepOrangeAccent),
                          ),
                          Icon(
                            Icons.upload_file,
                            color: Colors.deepOrangeAccent,
                          )
                          //arrow_forward_ios
                        ],
                      ),
                    ),
                  ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        // Barre de progression de l'upload
                        if (uploadProgress > 0)
                          LinearProgressIndicator(
                            value: uploadProgress,
                            color: Colors.deepOrangeAccent,
                            backgroundColor: Colors.grey[200],
                          ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: allFilesSelected ? uploadFiles : null,
                          // bouton inactif si tous les fichiers ne sont pas sélectionnés
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text('Soumettre',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoirFichiers()));
                          },
                          child: Text('Voir'),
                        )
                      ]),
                    ))
              ]),
            ))
      ])
    ]));
  }
}
