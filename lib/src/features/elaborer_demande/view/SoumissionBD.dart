import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:premierepage/filepage.dart';
import 'package:premierepage/src/constant/images.dart';

class SoumissionBD extends StatefulWidget {
  const SoumissionBD({
    super.key,
  });

  @override
  State<SoumissionBD> createState() => _SoumissionBDState();
}

class _SoumissionBDState extends State<SoumissionBD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
          Image.asset(BD, height: 135,),
          Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
            ),
            const SizedBox(
              height: 3,
            ),
            const Center(
              child: Text(
                'C\'est un domaine de l\'informatique qui se concentre sur la conception la mise en oeuvre et la gestion '
                    'des bases de données pour stocker, gerer et recupérer les données',
                style: TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Center(
              child: Column(
                children: [
                  Text(
                    '- - - Importer - - -',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),

//
            Container(
              // constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
              //  padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            color: Colors.white60,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            child: Column(children: [
                              const SizedBox(height: 8),
                              GestureDetector(
                                  child: const Text(
                                    ' Demande',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(allowMultiple: true);
                                    if (result == null) return;
                                    //openFiles(result.files);
                                    //open single file
                                    final file = result.files.first;
                                    // openFile(file);
//recupérons le nom ,l'extension ,...... de  l'image

                                    print('Name: ${file.name}');
                                    print('Bytes: ${file.bytes}');
                                    print('Size: ${file.size}');
                                    print('Extension: ${file.extension}');
                                    print('Path: ${file.path}');
                                    //sauvegarder
                                    //  final newFile = await saveFilePermanently (file);
                                    print('From Path: ${file.path!}');
                                    //  print('To Path: ${newFile.path}');
                                  }),
                              // SizedBox(width: 15,),
                              Icon(Icons.add)
                            ])),
                      ),
                      Expanded(
                          child: Card(
                              color: Colors.white60,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 25),
                              child: Column(children: [
                                const SizedBox(height: 8),
                                GestureDetector(
                                    child: const Text(
                                      'CV',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () async {
                                      final result = await FilePicker.platform
                                          .pickFiles(allowMultiple: true);
                                      if (result == null) return;
                                      //openFiles(result.files);
                                      //open single file
                                      final file = result.files.first;
                                      // openFile(file);
//recupérons le nom ,l'extension ,...... de  l'image

                                      print('Name: ${file.name}');
                                      print('Bytes: ${file.bytes}');
                                      print('Size: ${file.size}');
                                      print('Extension: ${file.extension}');
                                      print('Path: ${file.path}');
                                      //sauvegarder
                                      //  final newFile = await saveFilePermanently (file);
                                      print('From Path: ${file.path!}');
                                      //  print('To Path: ${newFile.path}');
                                    }),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(Icons.add)
                              ])))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            color: Colors.white60,
                            margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            child: Column(children: [
                              SizedBox(height: 8),
                              GestureDetector(
                                  child: const Text(
                                    'Photocopie CNI',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(allowMultiple: true);
                                    if (result == null) return;
                                    openFiles(result.files);
                                    //open single file
                                    final file = result.files.first;
                                    openFile(file);
//recupérons le nom ,l'extension ,...... de  l'image

                                    print('Name: ${file.name}');
                                    print('Bytes: ${file.bytes}');
                                    print('Size: ${file.size}');
                                    print('Extension: ${file.extension}');
                                    print('Path: ${file.path}');
                                    //sauvegarder
                                    //  final newFile = await saveFilePermanently (file);
                                    print('From Path: ${file.path!}');
                                    //  print('To Path: ${newFile.path}');
                                  }),
                              // SizedBox(width: 15,),
                              Icon(Icons.add)
                            ])),
                      ),
                      Expanded(
                          child: Card(
                              color: Colors.white60,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 25),
                              child: Column(children: [
                                const SizedBox(height: 8),
                                GestureDetector(
                                    child: const Text(
                                      'Certificat Scolarité',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () async {
                                      final result = await FilePicker.platform
                                          .pickFiles(allowMultiple: true);
                                      if (result == null) return;
                                      //openFiles(result.files);
                                      //open single file
                                      final file = result.files.first;
                                      // openFile(file);
//recupérons le nom ,l'extension ,...... de  l'image

                                      print('Name: ${file.name}');
                                      print('Bytes: ${file.bytes}');
                                      print('Size: ${file.size}');
                                      print('Extension: ${file.extension}');
                                      print('Path: ${file.path}');
                                      //sauvegarder
                                      //  final newFile = await saveFilePermanently (file);
                                      print('From Path: ${file.path!}');
                                      //  print('To Path: ${newFile.path}');
                                    }),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(Icons.add)
                              ])))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            color: Colors.white60,
                            margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            child: Column(children: [
                              SizedBox(height: 8),
                              GestureDetector(
                                  child: const Text(
                                    'Photos',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(allowMultiple: true);
                                    if (result == null) return;
                                    //openFiles(result.files);
                                    //open single file
                                    final file = result.files.first;
                                    // openFile(file);
//recupérons le nom ,l'extension ,...... de  l'image

                                    print('Name: ${file.name}');
                                    print('Bytes: ${file.bytes}');
                                    print('Size: ${file.size}');
                                    print('Extension: ${file.extension}');
                                    print('Path: ${file.path}');
                                    //sauvegarder
                                    //  final newFile = await saveFilePermanently (file);
                                    print('From Path: ${file.path!}');
                                    //  print('To Path: ${newFile.path}');
                                  }),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.add)
                            ])),
                      ),
                      Expanded(
                          child: Card(
                              color: Colors.white60,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 25),
                              child: Column(children: [
                                const SizedBox(height: 8),
                                GestureDetector(
                                    child: const Text(
                                      'Importer CV',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () async {
                                      final result = await FilePicker.platform
                                          .pickFiles(allowMultiple: true);
                                      if (result == null) return;
                                      //openFiles(result.files);
                                      //open single file
                                      final file = result.files.first;
                                      // openFile(file);
//recupérons le nom ,l'extension ,...... de  l'image

                                      print('Name: ${file.name}');
                                      print('Bytes: ${file.bytes}');
                                      print('Size: ${file.size}');
                                      print('Extension: ${file.extension}');
                                      print('Path: ${file.path}');
                                      //sauvegarder
                                      //  final newFile = await saveFilePermanently (file);
                                      print('From Path: ${file.path!}');
                                      //  print('To Path: ${newFile.path}');
                                    }),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(Icons.add)
                              ])))
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('envoi en cours ....')));
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FilesPag()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text('Soumettre',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)))
                ]))
          ]),
        ]));
  }

  void openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SoumissionBD(
            //  files:files,
            //  onOpenedFile: openFile,
          )));
  //ouvrir le fichier
  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File("${appStorage.path}/${file.name}");

    return File(file.path!).copy(newFile.path);
  }
}
