import 'package:flutter/material.dart';

class FilesPag extends StatefulWidget {
  const FilesPag({super.key});

  @override
  State<FilesPag> createState() => _FilesPagState();
}

class _FilesPagState extends State<FilesPag> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: 
      Column(
        children: [
          Text('bonjour')
        ],
      )
    );
  }
}
