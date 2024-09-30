/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilesPag extends StatefulWidget {
  const FilesPag({super.key});

  @override
  State<FilesPag> createState() => _FilesPagState();
}

class _FilesPagState extends State<FilesPag> {
  @override
  Widget build(BuildContext context) {
     Widget userListPage()*/
/**//*
 {

     }
      return Scaffold(
        appBar: AppBar(title: Text('Liste des utilisateurs')),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(user['email']),
                  subtitle: Text('Rôle : ${user['role']}'),
                );
              },
            );
          },
        ),

    );
  }
}
*/
