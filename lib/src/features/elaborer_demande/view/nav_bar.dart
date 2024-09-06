import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierepage/main.dart';

import 'package:premierepage/src/features/authentification/view/home_login.dart';
import 'package:premierepage/src/features/elaborer_demande/view/dossier.dart';
import 'package:premierepage/src/features/elaborer_demande/view/info.dart';
import 'package:premierepage/src/features/elaborer_demande/view/specialite.dart';

class navBar extends StatelessWidget {
   navBar({super.key});
   late Color myColor;

  @override
  Widget build(BuildContext context) {
  myColor = Theme.of(context).primaryColor;

    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('image/ordi2.JPG'),
    //COULEUR au dessus de l'image
    )),
      child:
      Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
    backgroundColor: Colors.deepOrangeAccent,
      ),

      body:
          Stack(
    children: [
        /*decoration: const BoxDecoration(
        gradient: LinearGradient(
        colors: [Colors.deepOrangeAccent, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight)
        ),
*/Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
          child: Column(
              children: [
Card(
  color: Colors.deepOrangeAccent,
  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
  elevation: 6,
  child: Column(
  children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>specialite()));
                  },
                  child: Image.asset('image/aca_isare.PNG',width: 270,height: 250,),

                )],),),
                Card(
                  color: Colors.deepOrangeAccent,
              elevation: 7,
                  margin: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
                  child: Column(
                  children: [
                    SizedBox(

                    child:

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>specialite()));
                      },
                      child: Image.asset('image/profe_isare.PNG', width: 226,height: 250,),

                    ))],),),
              ]

          ),
        ),]),

        //menu
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrangeAccent),
              child: Text('Menu',style: TextStyle(fontSize: 25, color: Colors.white),),
            ),
            ListTile(
              leading: const Icon(Icons.document_scanner),
              title: const Text('constitution dossier'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const dossier()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('info'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> info()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('quiter'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => navBar()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Deconnexion'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeLoginPage()));
              },
            ),
          ],
        ),

      ),

      ));
  }}

