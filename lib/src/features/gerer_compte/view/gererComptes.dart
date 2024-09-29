import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierepage/src/constant/images.dart';
import 'package:premierepage/src/features/gerer_compte/view/ajoutEncadrant.dart';
import 'package:premierepage/src/features/gerer_compte/view/ajoutStagiaire.dart';
import 'package:premierepage/src/features/gerer_compte/view/connectADMIN.dart';
import 'package:premierepage/src/features/gerer_compte/view/gerer%20demandes.dart';
import 'package:premierepage/src/features/gerer_compte/view/listFiles.dart';


class GererComptes extends StatefulWidget {
  const GererComptes({super.key});

  @override
  State<GererComptes> createState() => _GererComptesState();
}

class _GererComptesState extends State<GererComptes> {
  late Color myColor;
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;

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
                  title:
                  Text('GERER UTILISATEURS',style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),
                ),
                body: TabBarView(
                  children: [
                     Card(
                      child:
                            Stack(
                        children: [
                            Container(
                            decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(logo_stage),
                                colorFilter: ColorFilter.mode(
                                    myColor.withOpacity(0.1), BlendMode.dstATop)
                            ))),
                           Padding(
                             padding: EdgeInsets.symmetric( horizontal: 30,vertical: 25),

                             child:
                                 GestureDetector(
                                   onTap: (){
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ajouStagiaire()));
                                     Test().essai();
                                   },
                               child: Text('Ajouter Stagiaire',style: TextStyle(fontSize: 25,color: Colors.black),),
                             ),),
        Divider(height: 10,),
        Padding(
            padding: EdgeInsets.symmetric( horizontal: 30,vertical: 100),
                           child:
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ajoutEncadrant()));
                              },
                              child:
                            Text('Enregistrer Encadrant',style: TextStyle(fontSize: 25,color: Colors.black),),
                            ),
        ),
                          Divider(height: 160,),
                          Divider(height: 320,),
                        ] )),

                    Card(
                        child: Text('Gerer demandes')),
                    Card(
                        child: Text('Info stagiaires')),
                  ],
                ))));
  }
}
