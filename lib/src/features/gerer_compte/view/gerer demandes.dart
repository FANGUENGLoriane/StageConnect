
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
class GererDemandes extends StatefulWidget {
  @override
  _GererDemandesState createState() => _GererDemandesState();
}

class _GererDemandesState extends State<GererDemandes> {
  List<Map<String, dynamic>> allFiles =
      []; // Liste des fichiers des utilisateurs
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchAllUserFiles(); // Récupérer les fichiers dès le début
  }

  // Fonction pour vérifier si l'utilisateur est admin
  Future<bool> checkIfAdmin() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('utilisateur')
          .doc(user.uid)
          .get();
      return userDoc.exists && userDoc.get('typeCompte') == 'Administ';
    }
    return false;
  }
  // Fonction pour récupérer tous les fichiers des utilisateurs
  Future<void> fetchAllUserFiles() async {
    bool isAdmin = await checkIfAdmin();
    if (isAdmin) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        List<Map<String, dynamic>> fetchedFiles = [];

        // Ici, nous supposons que les fichiers sont organisés par UID dans un dossier par utilisateur
        ListResult allFolders = await storage.ref().listAll();

        for (Reference folder in allFolders.prefixes) {
          ListResult userFiles = await folder.listAll();

          for (Reference fileRef in userFiles.items) {
            String downloadUrl = await fileRef.getDownloadURL();
            fetchedFiles.add({
              "name": fileRef.name,
              "url": downloadUrl,
              "path": fileRef.fullPath, // Utilisé pour supprimer le fichier
            });
          }
        }

        setState(() {
          allFiles = fetchedFiles;
          isLoading = false;
        });
      } catch (e) {
        print("Erreur lors de la récupération des fichiers : $e");
      }
    } else {
      print("Accès refusé. Vous n'êtes pas administrateur.");
    }
  }
  // Fonction pour supprimer un fichier
  Future<void> deleteFile(String filePath) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      await storage.ref().child(filePath).delete();

      // Mettre à jour l'interface après suppression
      setState(() {
        allFiles.removeWhere((file) => file['path'] == filePath);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fichier supprimé')),
      );
    } catch (e) {
      print("Erreur lors de la suppression du fichier : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des fichiers des utilisateurs"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allFiles[index]['name']),
                  subtitle: Text(allFiles[index]['url']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteFile(allFiles[index]['path']);
                    },
                  ),
                  onTap: () {
                    _openFile(allFiles[index]['url']);
                  },
                );
              },
            ),
    );
  }

  // Fonction pour ouvrir ou afficher le fichier
  void _openFile(String fileUrl) {
    print("Ouverture du fichier : $fileUrl");
    // Utilisez un package comme url_launcher pour ouvrir le fichier
  }
}

*/


class FilesPage extends StatelessWidget {
  final String userId;

  FilesPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Dossiers")),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('fichiers').snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    }

    var files = snapshot.data!.docs;

    return ListView.builder(
    itemCount: files.length,
    itemBuilder: (context, index) {
    var file = files[index];
    return ListTile(
    title: Text(file['file_name']),
    subtitle: Text(file['uploaded_at']?.toDate().toString() ?? "No date"),
    trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    IconButton(
    icon: Icon(Icons.remove_red_eye),
    onPressed: () async {
    // Ouvrir le fichier
    final url = file['file_url'];
      // Vous pouvez utiliser un package comme url_launcher pour ouvrir l'URL dans un navigateur.
    },
    ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await deleteFile(userId, file.id, file['file_name']);
        },
      ),
    ],
    ),
    );
    },
    );
    },
        ));
  }

  // Supprimer un fichier
  Future<void> deleteFile(String userId, String fileId, String fileName) async {
    // Supprimer le fichier dans Firebase Storage
    Reference storageRef = FirebaseStorage.instance.ref('fichiers/$userId/$fileName');
    await storageRef.delete();

    // Supprimer les métadonnées dans Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).collection('fichiers').doc(fileId).delete();
  }
}

