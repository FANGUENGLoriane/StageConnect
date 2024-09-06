import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierepage/filepage.dart';
import 'package:premierepage/src/features/gerer_compte/view/ajoutEncadrant.dart';
import 'package:premierepage/src/features/gerer_compte/view/ajoutStagiaire.dart';

class GererComptes extends StatefulWidget {
  const GererComptes({super.key});

  @override
  State<GererComptes> createState() => _GererComptesState();
}

class _GererComptesState extends State<GererComptes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  // créons les onglets
                  //fonction
                  bottom: TabBar(tabs: <Widget>[
                    Tab(
                      child: Icon(Icons.person_2,color: Colors.white ),
                    ),
                    Tab(
                      child: Icon(Icons.history,color: Colors.white ,),
                    ),
                    Tab(
                      child: Icon(Icons.account_balance,color: Colors.white ),
                    ),
                  ]),
                  centerTitle: true,
                  backgroundColor: Colors.deepOrangeAccent,
                  title: Text(
                    'GERER',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                body: TabBarView(
                  children: [
                     Card(
                        child: Column(
                          children: [

                           Padding(
                             padding: EdgeInsets.symmetric( horizontal: 30,vertical: 20),
                             child:
                                 GestureDetector(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ajouStagiaire()));
                                   },
                               child: Text('Ajouter Stagiaire',style: TextStyle(fontSize: 35,color: Colors.black),),
                             ),),
                            SizedBox(height: 18,),
                            Divider(height: 25,color: Colors.deepOrangeAccent,),
                            Divider(height: 25,color: Colors.deepOrangeAccent,),
                            SizedBox(height: 18,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ajoutEncadrant()));
                              },
                              child:
                            Text('Enregistrer Encadrant',style: TextStyle(fontSize: 35,color: Colors.black),),

                            ),
                            SizedBox(height: 18,),
                            Divider(height: 25,color: Colors.deepOrangeAccent,),
                          ],
                        )),

                    Card(
                        child: Text('Gerer demandes')),
                    Card(
                        child: Text('Info stagiaires')),
                  ],
                ))));
  }
}
