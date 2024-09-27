
/*
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:premierepage/src/features/gerer_compte/view/connectADMIN.dart';
class listFolder extends StatefulWidget {
  const listFolder({super.key});

  @override
  State<listFolder> createState() => _listFolderState();
}

class _listFolderState extends State<listFolder> {
  late Future<ListResult> futureFiles;
  @override
  void initState(){
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/photoProfil').list();
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(('download'))
      ),

      body:
      FutureBuilder<ListResult>(future: futureFiles,
          builder: (context, snapshot){
        if(snapshot.hasData){
final files = snapshot.data!.items;
return ListView.builder(
    itemCount: files.length,
    itemBuilder: (context, index){
      final file = files[index];
      return ListTile(
        title: Text(file.name),
        trailing: IconButton(
            icon: Icon(Icons.download,color: Colors.black,),
        onPressed: ()=>connectADMIN(),
        ),
      );
    }
);
        }else if (snapshot.hasError){
          return const Center(child: Text('error occurred'),);
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
          }
      ),
    );

  }
  Future downloadFile(Reference ref) async{
    final url = await ref.getDownloadURL();
//not visible for user
  final tempDir = await getTemporaryDirectory();
  final path = File('${tempDir.path}/${ref.name}');
  await Dio().download(url, path);
  if(url.contains('.jpg')){
    await ImageGallerySaver.saveImage(path, toDcim: true);
  }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('download ${ref.name}'),));}
  }

*/

import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Test{

// Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref();

// Create a reference with an initial file path and name
//   get pathReference =>


void essai() {
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) async {
    if (user != null) {
      print("Je suis connecte =====================================");
      final String uid = user.uid;

      final islandRef = storageRef.child("users/$uid/");
      // final String url = await islandRef.getDownloadURL();
      final listResult = await islandRef.listAll();
      for (var prefix in listResult.prefixes) {
        debugPrint("essai: " + prefix.toString());
      }
    }
    else {
      debugPrint("======================================Deconnexion");
    }
  });
}

  // try {
  //   const oneMegabyte = 1024 * 1024;
  //   final data = await islandRef.getData(oneMegabyte);
  //   print("message: " + data.toString());
  //   // Data for "images/island.jpg" is returned, use this as needed.
  // } on FirebaseException catch (e) {
  //   // Handle any errors.
  // }

//   final appDocDir = await getApplicationDocumentsDirectory();
//   final filePath = "${appDocDir.absolute}/photoProfil/1726785546992.jpg";
//   final path = filePath.toString().substring(12, 61) + "/photoProfil/1726785546992.jpg";
//   final file = File(path);
//   //
//   // print("message: " + path.toString());
//   final downloadTask = islandRef.writeToFile(file);
//   downloadTask.snapshotEvents.listen((taskSnapshot) {
//     switch (taskSnapshot.state) {
//       case TaskState.running:
//       const CircularProgressIndicator();
//         break;
//       case TaskState.paused:
//         debugPrint("paused");
//         break;
//       case TaskState.success:
//         debugPrint("success");
//         break;
//       case TaskState.canceled:
//         debugPrint("canceled");
//         break;
//       case TaskState.error:
//         debugPrint("error");
//         break;
//     }
//   }
//   );
// }
}
